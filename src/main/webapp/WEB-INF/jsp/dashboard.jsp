<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Task Manager Dashboard</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        /* Apply Inter font */
        body { font-family: 'Inter', sans-serif; }

        /* Custom background gradient for immersive feel */
        .awesome-bg {
            background: #e0e7ff; /* Light indigo base */
            background-image: radial-gradient(at 10% 20%, #eff2ff 0%, #e0e7ff 100%);
        }

        /* Custom stronger shadow for cards */
        .card-shadow {
            box-shadow: 0 15px 30px -5px rgba(0, 0, 0, 0.1), 0 5px 5px -5px rgba(0, 0, 0, 0.04);
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary-indigo': '#4F46E5',
                        'primary-hover': '#4338CA',
                    },
                    boxShadow: {
                        // Custom shadow definition for card lift on hover
                        'card-lift': '0 25px 50px -12px rgba(79, 70, 229, 0.15)',
                    }
                }
            }
        }
    </script>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="awesome-bg min-h-screen">

<!-- Fixed Header / Navbar -->
<header class="sticky top-0 z-10 bg-white shadow-xl px-6 py-4 flex justify-between items-center border-b-2 border-primary-indigo/10">
    <div class="text-2xl font-extrabold text-primary-indigo tracking-tight flex items-center">
        <i class="fas fa-list-check mr-3 text-3xl"></i>
        Task Manager
    </div>
    <nav class="flex items-center space-x-4">
        <div class="text-sm text-gray-700">
            Welcome, <strong class="text-primary-indigo">${username}</strong>
        </div>
        <a href="<c:url value='/logout'/>" class="py-2 px-4 bg-red-500 text-white text-sm font-semibold rounded-lg shadow-md hover:bg-red-600 transition duration-200 ease-in-out transform active:scale-95">
            <i class="fas fa-sign-out-alt mr-1"></i> Logout
        </a>
    </nav>
</header>

<!-- Main Content Container -->
<div class="p-4 md:p-8 lg:p-12">
    <div class="max-w-7xl mx-auto">

        <h1 class="text-4xl font-bold text-gray-900 mb-8 mt-4">Task Management Dashboard</h1>

        <!-- Responsive Grid Layout (2 columns for desktop, 1 column for mobile) -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <!-- COLUMN 1: Create New Task Form -->
            <div class="lg:col-span-1">
                <div class="bg-white p-8 rounded-2xl card-shadow border-t-4 border-primary-indigo/80 transform transition duration-500 ease-in-out hover:scale-[1.01] hover:shadow-card-lift">
                    <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center">
                        <i class="fas fa-plus-circle mr-3 text-primary-indigo"></i>
                        Create a New Task
                    </h2>

                    <!-- Form for Task Data -->
                    <form action="<c:url value='/tasks'/>" method="post">
                        <div class="mb-5">
                            <label for="title" class="block text-sm font-semibold text-gray-700 mb-2">Task Title</label>
                            <input id="title" name="title" type="text" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                                   placeholder="e.g., Schedule meeting with team" />
                        </div>

                        <div class="mb-5">
                            <label for="description" class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                            <textarea id="description" name="description"
                                      class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                                      placeholder="Optional details, notes, or next steps..."></textarea>
                        </div>

                        <div class="mb-5">
                            <label for="stage" class="block text-sm font-semibold text-gray-700 mb-2">Status</label>
                            <select id="stage" name="status"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                            >
                                <option value="PENDING">To Do</option>
                                <option value="LATER">In Progress</option>
                                <option value="DONE">Completed</option>
                            </select>
                        </div>

                        <div class="mb-5">
                            <label for="priority" class="block text-sm font-semibold text-gray-700 mb-2">Priority</label>
                            <select id="priority" name="priority"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                            >
                                <option value="HIGH">High</option>
                                <option value="MEDIUM" selected>Medium</option>
                                <option value="LOW">Low</option>
                            </select>
                        </div>

                        <div class="mb-5">
                            <label for="dueDate" class="block text-sm font-semibold text-gray-700 mb-2">Due Date</label>
                            <input id="dueDate" name="dueDate" type="datetime-local"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                                   placeholder="Select due date and time" />
                        </div>

                        <div class="mb-8">
                            <label for="reminderAt" class="block text-sm font-semibold text-gray-700 mb-2">Reminder</label>
                            <input id="reminderAt" name="reminderAt" type="datetime-local"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner"
                                   placeholder="Select reminder date and time" />
                        </div>

                        <button type="submit"
                                class="w-full py-3 px-4 bg-primary-indigo text-white font-bold rounded-xl shadow-lg shadow-indigo-500/50 hover:bg-primary-hover focus:outline-none focus:ring-4 focus:ring-primary-indigo focus:ring-opacity-70 transition duration-300 ease-in-out transform hover:scale-[1.01] active:scale-[0.98] active:shadow-md"
                        >
                            <i class="fas fa-plus mr-1"></i> Add Task
                        </button>
                    </form>
                </div>

            </div>

            <!-- COLUMN 2: Your Tasks List -->
            <div class="lg:col-span-2">
                <div class="bg-white p-8 rounded-2xl card-shadow transform transition duration-500 ease-in-out">
                    <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center border-b pb-4">
                        <i class="fas fa-tasks mr-3 text-primary-indigo"></i>
                        Your Tasks
                    </h2>

                    <!-- Filters -->
                    <div class="flex flex-wrap items-center gap-3 mb-4">
                        <button id="btnShowAll" class="py-2 px-3 bg-gray-200 text-gray-800 text-sm font-semibold rounded-lg hover:bg-gray-300 transition">Show All</button>
                        <button id="btnHighPriority" class="py-2 px-3 bg-red-100 text-red-700 text-sm font-semibold rounded-lg hover:bg-red-200 transition">High Priority</button>
                        <button id="btnInProgress" class="py-2 px-3 bg-blue-100 text-blue-700 text-sm font-semibold rounded-lg hover:bg-blue-200 transition">In Progress</button>
                    </div>

                    <c:choose>
                        <c:when test="${empty tasks}">
                            <div class="p-8 text-center text-gray-500 border border-dashed rounded-xl mt-4">
                                <i class="fas fa-clipboard-list text-5xl mb-3"></i>
                                <p class="text-lg font-semibold">You have no tasks yet.</p>
                                <p class="text-sm">Use the form on the left to add your first task to the list.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                    <tr>
                                        <th data-sort="title" scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-1/5 cursor-pointer select-none">Title ▲▼</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-1/3">Description</th>
                                        <th data-sort="status" scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-1/6 cursor-pointer select-none">Status ▲▼</th>
                                        <th data-sort="priority" scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-1/6 cursor-pointer select-none">Priority ▲▼</th>
                                        <th scope="col" class="px-6 py-3 text-center text-xs font-semibold text-gray-500 uppercase tracking-wider w-1/5">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody id="taskTableBody" class="bg-white divide-y divide-gray-100">
                                    <c:forEach var="t" items="${tasks}">
                                        <tr class="hover:bg-indigo-50 transition duration-150" data-id="${t.id}" data-status="${t.status}" data-priority="${empty t.priority ? 'MEDIUM' : t.priority}" data-due="${t.dueDate}" data-reminder="${t.reminderAt}">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${t.title}</td>
                                            <td class="px-6 py-4 whitespace-normal text-sm text-gray-700">
                                                <div>${t.description}</div>
                                                <div class="mt-1 space-x-2 text-xs text-gray-500">
                                                    <c:if test="${not empty t.dueDate}">
                                                        <span class="inline-flex items-center js-due" data-value="${t.dueDate}"><i class="far fa-calendar-alt mr-1 text-primary-indigo"></i> Due: ${t.dueDate}</span>
                                                    </c:if>
                                                    <c:if test="${not empty t.reminderAt}">
                                                        <span class="inline-flex items-center js-reminder" data-value="${t.reminderAt}"><i class="far fa-bell mr-1 text-amber-500"></i> Reminder: ${t.reminderAt}</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <!-- Status Badges for Task Status -->
                                                <span
                                                        class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                        <c:choose>
                                                            <c:when test="${t.status eq 'DONE'}">bg-green-100 text-green-800 border border-green-300">COMPLETED</c:when>
                                                            <c:when test="${t.status eq 'PENDING'}">bg-yellow-100 text-yellow-800 border border-yellow-300">TO DO</c:when>
                                                            <c:otherwise>bg-blue-100 text-blue-800 border border-blue-300">IN PROGRESS</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                    <c:choose>
                                                        <c:when test='${empty t.priority || t.priority eq "MEDIUM"}'>bg-gray-100 text-gray-800 border border-gray-300">MEDIUM</c:when>
                                                        <c:when test='${t.priority eq "HIGH"}'>bg-red-100 text-red-800 border border-red-300">HIGH</c:when>
                                                        <c:otherwise>bg-emerald-100 text-emerald-800 border border-emerald-300">LOW</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-center text-sm font-medium space-x-2">
                                                <a href="<c:url value='/tasks/${t.id}/edit' />"
                                                   class="inline-flex items-center justify-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-primary-indigo bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-indigo transition duration-150 transform hover:scale-[1.05] active:scale-[0.98]"
                                                >
                                                    <i class="fas fa-pencil-alt"></i> Edit
                                                </a>

                                                <form action="<c:url value='/tasks/${t.id}/delete'/>" method="post" class="inline delete-form" data-title="${t.title}">
                                                    <button type="submit"
                                                            class="inline-flex items-center justify-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-red-700 bg-red-100 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition duration-150 transform hover:scale-[1.05] active:scale-[0.98]"
                                                    >
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    (function() {
        const tbody = document.getElementById('taskTableBody');
        if (!tbody) return;

        // Filter buttons
        const btnShowAll = document.getElementById('btnShowAll');
        const btnHighPriority = document.getElementById('btnHighPriority');
        const btnInProgress = document.getElementById('btnInProgress');

        function showAll() {
            Array.from(tbody.rows).forEach(r => r.classList.remove('hidden'));
        }
        function filterHighPriority() {
            Array.from(tbody.rows).forEach(r => {
                const p = (r.getAttribute('data-priority') || 'MEDIUM').toUpperCase();
                r.classList.toggle('hidden', p !== 'HIGH');
            });
        }
        function filterInProgress() {
            Array.from(tbody.rows).forEach(r => {
                const s = (r.getAttribute('data-status') || '').toUpperCase();
                r.classList.toggle('hidden', s !== 'LATER');
            });
        }
        if (btnShowAll) btnShowAll.addEventListener('click', function(e){ e.preventDefault(); showAll(); });
        if (btnHighPriority) btnHighPriority.addEventListener('click', function(e){ e.preventDefault(); filterHighPriority(); });
        if (btnInProgress) btnInProgress.addEventListener('click', function(e){ e.preventDefault(); filterInProgress(); });

        // Sorting
        let sortState = { key: null, dir: 1 }; // 1 asc, -1 desc
        function getCellValue(row, key) {
            if (key === 'title') {
                return row.cells[0].textContent.trim().toUpperCase();
            } else if (key === 'status') {
                // Use data-status to avoid reading badge text
                return (row.getAttribute('data-status') || '').toUpperCase();
            } else if (key === 'priority') {
                return (row.getAttribute('data-priority') || 'MEDIUM').toUpperCase();
            }
            return '';
        }
        function sortBy(key) {
            if (sortState.key === key) {
                sortState.dir *= -1; // toggle
            } else {
                sortState.key = key;
                sortState.dir = 1;
            }
            const rows = Array.from(tbody.rows).filter(r => !r.classList.contains('hidden'));
            rows.sort((a, b) => {
                const va = getCellValue(a, key);
                const vb = getCellValue(b, key);
                if (va < vb) return -1 * sortState.dir;
                if (va > vb) return 1 * sortState.dir;
                return 0;
            });
            // Reattach in new order, while keeping hidden rows at the end in their relative order
            const hiddenRows = Array.from(tbody.rows).filter(r => r.classList.contains('hidden'));
            tbody.innerHTML = '';
            rows.forEach(r => tbody.appendChild(r));
            hiddenRows.forEach(r => tbody.appendChild(r));
        }
        (function(){
            var ths = document.querySelectorAll('th[data-sort]');
            if (!ths) return;
            ths.forEach(function(th){
                th.addEventListener('click', function(){ sortBy(this.getAttribute('data-sort')); });
            });
        })();
    })();
</script>
<script>
    // SweetAlert2 success toasts based on flash attributes
</script>
<script>

    // Reminder Toasts Logic
    (function(){
        const tbody = document.getElementById('taskTableBody');
        if(!tbody) return;
        const KEY_PREFIX = 'task_reminded_';
        function parseDate(s){ if(!s) return null; // Expect ISO like 2025-10-01T20:00
            const d = new Date(s); return isNaN(d.getTime()) ? null : d; }
        function check(){
            const now = new Date().getTime();
            Array.from(tbody.rows).forEach(r => {
                const id = r.getAttribute('data-id');
                const title = (r.cells[0] && r.cells[0].textContent ? r.cells[0].textContent.trim() : 'Task reminder');
                const whenStr = r.getAttribute('data-reminder');
                const when = parseDate(whenStr);
                if(!id || !when) return;
                const key = KEY_PREFIX + id + '_' + whenStr;
                if(localStorage.getItem(key)) return; // already reminded
                if(when.getTime() <= now){
                    localStorage.setItem(key, '1');
                    try{
                        Swal.fire({
                            toast:true, position:'top-end', icon:'info',
                            title: 'Reminder: ' + title,
                            text: 'It\'s time to check this task.',
                            showConfirmButton:false, timer:4000, timerProgressBar:true
                        });
                    }catch(e){}
                }
            });
        }
        // Check now and then every 30 seconds
        check();
        setInterval(check, 30000);
    })();
</script>
<c:if test="${loginSuccess}">
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: 'Welcome back, ${username}!',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>
<c:if test="${taskAdded}">
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: 'Task added successfully',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>
<c:if test="${taskUpdated}">
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: 'Task updated successfully',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>
<c:if test="${taskDeleted}">
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: 'Task deleted successfully',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>
<script>
    // SweetAlert2 delete confirmation for forms
    document.addEventListener('DOMContentLoaded', function() {
        const deleteForms = document.querySelectorAll('form.delete-form');
        deleteForms.forEach(function(form) {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                const title = form.getAttribute('data-title') || 'this task';
                Swal.fire({
                    title: 'Delete task?',
                    text: 'Are you sure you want to delete: ' + title + '?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        });
    });
</script>
<script>
    // Format Due/Reminder labels to a pretty local date-time string
    (function(){
        function formatNice(s){
            if(!s) return '';
            try{
                const d = new Date(s);
                if(isNaN(d.getTime())){
                    const t = s.length >= 16 ? s.substring(0,16) : s;
                    const d2 = new Date(t);
                    if(isNaN(d2.getTime())) return s; else return d2.toLocaleString();
                }
                return d.toLocaleString();
            }catch(e){ return s; }
        }
        document.addEventListener('DOMContentLoaded', function(){
            var nodes = document.querySelectorAll('.js-due, .js-reminder');
            if(!nodes) return;
            nodes.forEach(function(el){
                const val = el.getAttribute('data-value');
                const isDue = el.classList.contains('js-due');
                const label = isDue ? 'Due: ' : 'Reminder: ';
                var iconEl = el.querySelector('i');
                var icon = iconEl ? iconEl.outerHTML : '';
                el.innerHTML = icon + ' ' + label + formatNice(val);
            });
        });
    })();
</script>
</body>
</html>
