<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Resource List</title>
    <meta charset="UTF-8">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6 text-gray-800">Resource List</h1>

    <!-- Resource List Table -->
    <table class="w-full bg-white shadow-md rounded-lg overflow-hidden">
        <thead class="bg-gray-200">
        <tr>
            <th class="p-3 text-left">ID</th>
            <th class="p-3 text-left">Name</th>
            <th class="p-3 text-left">Type</th>
            <th class="p-3 text-left">Quantity</th>
            <th class="p-3 text-left">Supplier Info</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="ressource" items="${ressources}">
            <tr class="border-b">
                <td class="p-3">${ressource.id}</td>
                <td class="p-3">${ressource.nom}</td>
                <td class="p-3">${ressource.type}</td>
                <td class="p-3">${ressource.quantite}</td>
                <td class="p-3">${ressource.infoFournisseur}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Add Resource Form -->
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Resource</h2>
    <form action="ressource" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <div class="mb-4">
            <label class="block text-gray-700">Name:</label>
            <input type="text" name="nom" class="w-full p-2 border rounded-md" required>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Type:</label>
            <input type="text" name="type" class="w-full p-2 border rounded-md" required>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Quantity:</label>
            <input type="number" name="quantite" class="w-full p-2 border rounded-md" required>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Supplier Info:</label>
            <input type="text" name="infoFournisseur" class="w-full p-2 border rounded-md">
        </div>
        <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Resource</button>
    </form>
</div>
</body>
</html>