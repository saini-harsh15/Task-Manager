<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Something went wrong</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .awesome-bg {
            background: #e0e7ff;
            background-image: radial-gradient(at 10% 20%, #eff2ff 0%, #e0e7ff 100%);
        }
    </style>
</head>
<body class="awesome-bg flex items-center justify-center min-h-screen p-4">
<div class="w-full max-w-xl bg-white p-8 md:p-10 rounded-2xl shadow-xl border-t-4 border-red-500">
    <h1 class="text-3xl font-extrabold text-gray-900 mb-4">Oops! Something went wrong.</h1>
    <p class="text-gray-700 mb-6">
        We couldn't process your request right now.
        <c:if test="${not empty message}">
            <br/>Message: ${message}
        </c:if>
        <c:if test="${not empty error}">
            <br/>Error: ${error}
        </c:if>
        <c:if test="${not empty status}">
            <br/>Status: ${status}
        </c:if>
        <c:if test="${not empty path}">
            <br/>Path: ${path}
        </c:if>
    </p>
    <div class="flex flex-wrap gap-3">
        <a href="<c:url value='/'/>" class="py-2 px-4 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">Go Home</a>
        <a href="<c:url value='/login'/>" class="py-2 px-4 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition">Login</a>
        <a href="<c:url value='/register'/>" class="py-2 px-4 bg-green-600 text-white rounded-lg hover:bg-green-700 transition">Register</a>
    </div>
</div>
</body>
</html>