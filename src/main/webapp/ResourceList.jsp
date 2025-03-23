<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Construction Xpert - Resources</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="font-sans bg-gray-50">
<nav class="bg-green-800 text-white">
    <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center">
            <div class="w-10 h-10 bg-white rounded-md flex items-center justify-center mr-2">
                <div class="w-6 h-6 border-2 border-green-800"></div>
            </div>
            <div>
                <div class="text-sm font-bold">CONSTRUCTION</div>
                <div class="text-sm font-bold">XPERT</div>
            </div>
        </div>
        <ul class="hidden md:flex space-x-6">
            <li><a href="index.jsp" class="hover:text-green-300 font-medium">HOME</a></li>
            <li><a href="projet" class="hover:text-green-300 font-medium">PROJECTS</a></li>
            <li><a href="tache" class="hover:text-green-300 font-medium">TASKS</a></li>
            <li><a href="ressource" class="hover:text-green-300 font-medium">RESOURCES</a></li>
        </ul>
    </div>
</nav>

<c:if test="${not empty param.newResourceId}">
    <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mx-6 mt-6 rounded shadow">
        <p class="font-bold">Resource Added Successfully!</p>
        <p class="text-sm">The new resource has been added to Task #${param.taskId}.</p>
    </div>
</c:if>

<section class="container mx-auto px-6 py-20">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-green-800">Resources for Task #${param.taskId}</h2>
        <a href="ressource?action=new&taskId=${param.taskId}" class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-lg">Add Resource</a>
    </div>
    <div class="bg-white p-6 rounded-lg shadow-xl border-t-4 border-green-600">
        <table class="w-full text-left">
            <thead>
            <tr class="bg-green-600 text-white">
                <th class="p-3">Name</th>
                <th class="p-3">Type</th>
                <th class="p-3">Quantity</th>
                <th class="p-3">Supplier Info</th>
                <th class="p-3">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ressource" items="${ressources}">
                <tr class="${ressource.id == param.newResourceId ? 'bg-green-100 border-b' : 'border-b hover:bg-gray-100'}">
                    <td class="p-3">${ressource.nom}</td>
                    <td class="p-3">${ressource.type}</td>
                    <td class="p-3">${ressource.quantite}</td>
                    <td class="p-3">${ressource.infoFournisseur}</td>
                    <td class="p-3">
                        <a href="ressource?action=edit&id=${ressource.id}&taskId=${param.taskId}" class="text-green-600 hover:text-green-800">Edit</a>
                        <a href="ressource?action=delete&id=${ressource.id}&taskId=${param.taskId}" class="text-red-600 hover:text-red-800 ml-4">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty ressources}">
                <tr>
                    <td colspan="5" class="p-3 text-center text-gray-500">No resources found for this task.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <div class="mt-6">
        <a href="tache?projetId=${projetId}" class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-2 px-4 rounded-lg">Back to Tasks</a>
    </div>
</section>

<footer class="bg-green-800 text-white py-8">
    <div class="container mx-auto px-6 text-center">
        <div class="flex items-center justify-center mb-4">
            <div class="w-8 h-8 bg-white rounded-md flex items-center justify-center mr-2">
                <div class="w-5 h-5 border-2 border-green-800"></div>
            </div>
            <span class="font-bold">CONSTRUCTION XPERT</span>
        </div>
        <div class="text-sm">© 2025 Construction Xpert. All rights reserved.</div>
    </div>
</footer>
</body>
</html>