<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Task - ${task.title}</title>
    <!-- Load Tailwind CSS and Icons -->
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
                        'secondary-gray': '#6B7280',
                    },
                    boxShadow: {
                        // Custom shadow definition for card lift on hover
                        'card-lift': '0 25px 50px -12px rgba(79, 70, 229, 0.15)',
                    }
                }
            }
        }
    </script>
</head>
<body class="awesome-bg min-h-screen flex items-center justify-center p-4">

<!-- Card Container - Enhanced shadows, lift, and border -->
<div class="w-full max-w-lg bg-white p-8 rounded-2xl card-shadow border-t-4 border-primary-indigo/80 transform transition duration-500 ease-in-out hover:scale-[1.01] hover:shadow-card-lift">

    <h2 class="text-3xl font-bold text-gray-900 mb-8 flex items-center">
        <i class="fas fa-edit mr-3 text-primary-indigo"></i>
        Edit Task: <span class="ml-2 truncate max-w-xs">${task.title}</span>
    </h2>

    <!-- Form for updating the task -->
    <form action="<c:url value='/tasks/${task.id}/update'/>" method="post">

        <div class="mb-5">
            <label for="title" class="block text-sm font-semibold text-gray-700 mb-2">Task Title</label>
            <input id="title" name="title" type="text" value="${task.title}" required
                   class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                   placeholder="Enter a descriptive title" />
        </div>

        <div class="mb-5">
            <label for="description" class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
            <textarea id="description" name="description"
                      class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner min-h-[120px] hover:border-primary-indigo/50"
                      placeholder="Optional details, notes, or next steps..."
            >${task.description}</textarea>
        </div>

        <div class="mb-5">
            <label for="status" class="block text-sm font-semibold text-gray-700 mb-2">Status</label>
            <select id="status" name="status"
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
            >
                <option value="PENDING" ${task.status == 'PENDING' ? 'selected' : ''}>To Do</option>
                <option value="LATER" ${task.status == 'LATER' ? 'selected' : ''}>In Progress</option>
                <option value="DONE" ${task.status == 'DONE' ? 'selected' : ''}>Completed</option>
            </select>
        </div>

        <div class="mb-8">
            <label for="priority" class="block text-sm font-semibold text-gray-700 mb-2">Priority</label>
            <select id="priority" name="priority"
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
            >
                <option value="HIGH" ${task.priority == 'HIGH' ? 'selected' : ''}>High</option>
                <option value="MEDIUM" ${task.priority == 'MEDIUM' ? 'selected' : ''}>Medium</option>
                <option value="LOW" ${task.priority == 'LOW' ? 'selected' : ''}>Low</option>
            </select>
        </div>

        <!-- Actions -->
        <div class="flex justify-between items-center space-x-4">

            <!-- Back Button (Secondary Style) -->
            <a href="<c:url value='/dashboard'/>"
               class="flex-1 py-3 px-4 bg-gray-200 text-secondary-gray font-bold rounded-xl shadow-md hover:bg-gray-300 focus:outline-none focus:ring-4 focus:ring-gray-400 focus:ring-opacity-70 transition duration-300 ease-in-out transform hover:scale-[1.02] active:scale-[0.98] active:shadow-sm text-center"
            >
                <i class="fas fa-arrow-left mr-1"></i> Back to Dashboard
            </a>

            <!-- Update Button (Primary Style) -->
            <button type="submit"
                    class="flex-1 py-3 px-4 bg-primary-indigo text-white font-bold rounded-xl shadow-lg shadow-indigo-500/50 hover:bg-primary-hover focus:outline-none focus:ring-4 focus:ring-primary-indigo focus:ring-opacity-70 transition duration-300 ease-in-out transform hover:scale-[1.02] active:scale-[0.98] active:shadow-md"
            >
                <i class="fas fa-save mr-1"></i> Update Task
            </button>
        </div>
    </form>
</div>
</body>
</html>
