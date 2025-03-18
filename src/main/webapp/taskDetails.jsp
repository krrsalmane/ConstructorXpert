<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Details</title>
    <meta charset="UTF-8">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6 text-gray-800">Tasks for Project ID: ${projetId}</h1>

    <!-- Task List Table -->
    <table class="w-full bg-white shadow-md rounded-lg overflow-hidden">
        <thead class="bg-gray-200">
        <tr>
            <th class="p-3 text-left">ID</th>
            <th class="p-3 text-left">Description</th>
            <th class="p-3 text-left">Start Date</th>
            <th class="p-3 text-left">End Date</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="tache" items="${taches}">
            <tr class="border-b">
                <td class="p-3">${tache.id}</td>
                <td class="p-3">${tache.description}</td>
                <td class="p-3">${tache.dateDebut}</td>
                <td class="p-3">${tache.dateFin}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Add Task Form -->
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Task</h2>
    <form action="tache" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <input type="hidden" name="projetId" value="${projetId}">
        <div class="mb-4">
            <label class="block text-gray-700">Description:</label>
            <input type="text" name="description" class="w-full p-2 border rounded-md" required>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Start Date:</label>
            <input type="date" name="dateDebut" class="w-full p-2 border rounded-md" required>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">End Date:</label>
            <input type="date" name="dateFin" class="w-full p-2 border rounded-md" required>
        </div>
        <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Task</button>
    </form>
</div>
</body>
</html>