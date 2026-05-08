<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login to Task Manager</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }

        .awesome-bg {
            background: #e0e7ff; /* Light indigo base */
            background-image: radial-gradient(at 10% 20%, #eff2ff 0%, #e0e7ff 100%);
        }

        .card-shadow {
            /* Deeper shadow for a more grounded 3D effect */
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
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
                        // Custom shadow definition for the dramatic card lift on hover
                        'card-lift': '0 25px 50px -12px rgba(79, 70, 229, 0.25)',
                    }
                }
            }
        }
    </script>
</head>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<body class="awesome-bg flex items-center justify-center min-h-screen p-4 transition-all duration-700">

<!-- Login Card Container - Enhanced shadows, lift, and border -->
<div class="w-full max-w-md bg-white p-8 md:p-10 rounded-2xl card-shadow border-t-4 border-primary-indigo transform hover:scale-[1.01] hover:shadow-card-lift transition duration-500 ease-in-out">

    <!-- Header -->
    <h2 class="text-4xl font-extrabold text-center text-gray-900 mb-2 tracking-tight">
        Welcome Back!
    </h2>
    <p class="text-center text-gray-500 mb-8 text-lg">
        Sign in to access your Task Manager dashboard.
    </p>

    <!-- Message/Error Display (Unified styling) -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl relative mb-6 text-sm transform hover:scale-[1.02] transition duration-200">
                ${error}
        </div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl relative mb-6 text-sm transform hover:scale-[1.02] transition duration-200">
                ${message}
        </div>
    </c:if>

    <!-- Login Form -->
    <form action="<c:url value='/login'/>" method="POST">

        <!-- Username Field -->
        <div class="mb-5">
            <label for="username" class="block text-sm font-semibold text-gray-700 mb-2">Username</label>
            <input
                    id="username"
                    name="username"
                    type="text"
                    value="${username}"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                    placeholder="Your username"
            />
        </div>

        <!-- Password Field -->
        <div class="mb-8">
            <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">Password</label>
            <input
                    id="password"
                    name="password"
                    type="password"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                    placeholder="Enter Your Password"
            />
        </div>

        <!-- Submit Button - Enhanced with colored shadow, lift on hover, and press effect on click -->
        <button type="submit"
                class="w-full py-3 px-4 bg-primary-indigo text-white font-bold rounded-xl shadow-lg shadow-indigo-500/50 hover:bg-primary-hover focus:outline-none focus:ring-4 focus:ring-primary-indigo focus:ring-opacity-70 transition duration-300 ease-in-out transform hover:scale-[1.02] active:scale-[0.98] active:shadow-md"
        >
            Login
        </button>
    </form>

    <!-- Register Link -->
    <div class="text-center text-sm text-gray-600 mt-6">
        New here?
        <a href="<c:url value="/register" />" class="text-primary-indigo hover:text-primary-hover font-semibold transition duration-150 hover:underline">
            Create an account
        </a>
    </div>
</div>

<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Login failed',
            text: '${fn:escapeXml(error)}',
            confirmButtonColor: '#4F46E5'
        });
    </script>
</c:if>
<c:if test="${logoutSuccess}">
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: 'You have been logged out successfully',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    </script>
</c:if>
</body>
</html>
