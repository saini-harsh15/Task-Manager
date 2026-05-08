<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register for Task Manager</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Apply Inter font */
        body { font-family: 'Inter', sans-serif; }

        /* Custom background gradient for an absolutely awesome look */
        .awesome-bg {
            background: #e0e7ff; /* Light indigo base */
            background-image: radial-gradient(at 10% 20%, #eff2ff 0%, #e0e7ff 100%);
        }

        /* Custom stronger shadow for the card */
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
<body class="awesome-bg flex items-center justify-center min-h-screen p-4 transition-all duration-700">

<!-- Registration Card Container - Enhanced shadows, lift, and border -->
<div class="w-full max-w-md bg-white p-8 md:p-10 rounded-2xl card-shadow border-t-4 border-primary-indigo transform hover:scale-[1.01] hover:shadow-card-lift transition duration-500 ease-in-out">

    <!-- Header -->
    <h2 class="text-4xl font-extrabold text-center text-gray-900 mb-2 tracking-tight">
        Task Manager
    </h2>
    <p class="text-center text-gray-500 mb-8 text-lg">
        Create your account to start managing tasks.
    </p>

    <!-- Error Message Display - Added subtle hover effect -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl relative mb-6 text-sm transform hover:scale-[1.02] transition duration-200">
                ${error}
        </div>
    </c:if>

    <!-- Registration Form (using Spring Form tags) -->
    <form:form action="register" method="POST" modelAttribute="user">

        <!-- Username Field - Added inner shadow and stronger focus/hover effects -->
        <div class="mb-5">
            <label for="username" class="block text-sm font-semibold text-gray-700 mb-2">Username</label>
            <form:input
                    path="username"
                    id="username"
                    type="text"
                    required="true"
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                    placeholder="Enter a unique username"
            />
        </div>

        <!-- Email Field - Added inner shadow and stronger focus/hover effects -->
        <div class="mb-5">
            <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">Email Address</label>
            <form:input
                    path="email"
                    id="email"
                    type="email"
                    required="true"
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                    placeholder="Enter your Email Address"
            />
        </div>

        <!-- Password Field - Added inner shadow and stronger focus/hover effects -->
        <div class="mb-8">
            <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">Password</label>
            <form:input
                    path="password"
                    id="password"
                    type="password"
                    required="true"
                    class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-primary-indigo/50 focus:border-primary-indigo transition duration-200 ease-in-out shadow-inner hover:border-primary-indigo/50"
                    placeholder="Enter a Strong Password"
            />
        </div>

        <!-- Submit Button - Enhanced with colored shadow, lift on hover, and press effect on click -->
        <button type="submit"
                class="w-full py-3 px-4 bg-primary-indigo text-white font-bold rounded-xl shadow-lg shadow-indigo-500/50 hover:bg-primary-hover focus:outline-none focus:ring-4 focus:ring-primary-indigo focus:ring-opacity-70 transition duration-300 ease-in-out transform hover:scale-[1.02] active:scale-[0.98] active:shadow-md"
        >
            Create Account
        </button>

    </form:form>

    <!-- Login Link - Added subtle underline on hover -->
    <div class="text-center text-sm text-gray-600 mt-6">
        Already have an account?
        <a href="<c:url value="/login" />" class="text-primary-indigo hover:text-primary-hover font-semibold transition duration-150 hover:underline">
            Login here
        </a>
    </div>
</div>
</body>
</html>
