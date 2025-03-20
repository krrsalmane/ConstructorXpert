<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Resource List</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6 text-gray-800">Resources</h1>

    <table class="w-full bg-white shadow-md rounded-lg overflow-hidden">
        <thead class="bg-gray-200">
        <tr>
            <th class="p-3 text-left">ID</th>
            <th class="p-3 text-left">Name</th>
            <th class="p-3 text-left">Type</th>
            <th class="p-3 text-left">Quantity</th>
            <th class="p-3 text-left">Supplier Info</th>
            <th class="p-3 text-left">Actions</th>
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
                <td class="p-3 space-x-2">
                    <a href="ressource?action=edit&id=${ressource.id}" class="text-green-500 hover:underline">Edit</a>
                    <a href="ressource?action=delete&id=${ressource.id}" class="text-red-500 hover:underline" onclick="return confirm('Are you sure you want to delete this resource?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Add New Resource Form -->
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Resource</h2>
    <form action="ressource" method="post" class="bg-white p-6 rounded-lg shadow-md" id="addResourceForm">
        <input type="hidden" name="action" value="add">
        <div class="mb-4">
            <label class="block text-gray-700">Name:</label>
            <input type="text" name="nom" id="addNom" class="w-full p-2 border rounded-md">
            <span id="addNomError" class="text-red-500 text-sm hidden">Name is required</span>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Type:</label>
            <input type="text" name="type" id="addType" class="w-full p-2 border rounded-md">
            <span id="addTypeError" class="text-red-500 text-sm hidden">Type is required</span>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Quantity:</label>
            <input type="number" name="quantite" id="addQuantite" class="w-full p-2 border rounded-md">
            <span id="addQuantiteError" class="text-red-500 text-sm hidden">Quantity is required and must be positive</span>
        </div>
        <div class="mb-4">
            <label class="block text-gray-700">Supplier Info:</label>
            <input type="text" name="infoFournisseur" id="addInfoFournisseur" class="w-full p-2 border rounded-md">
            <span id="addInfoFournisseurError" class="text-red-500 text-sm hidden">Supplier info is required</span>
        </div>
        <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Resource</button>
    </form>

    <!-- Edit Resource Form (shown only if editing) -->
    <c:if test="${not empty ressourceToEdit}">
        <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Edit Resource</h2>
        <form action="ressource" method="post" class="bg-white p-6 rounded-lg shadow-md" id="editResourceForm">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${ressourceToEdit.id}">
            <div class="mb-4">
                <label class="block text-gray-700">Name:</label>
                <input type="text" name="nom" id="editNom" value="${ressourceToEdit.nom}" class="w-full p-2 border rounded-md">
                <span id="editNomError" class="text-red-500 text-sm hidden">Name is required</span>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Type:</label>
                <input type="text" name="type" id="editType" value="${ressourceToEdit.type}" class="w-full p-2 border rounded-md">
                <span id="editTypeError" class="text-red-500 text-sm hidden">Type is required</span>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Quantity:</label>
                <input type="number" name="quantite" id="editQuantite" value="${ressourceToEdit.quantite}" class="w-full p-2 border rounded-md">
                <span id="editQuantiteError" class="text-red-500 text-sm hidden">Quantity is required and must be positive</span>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Supplier Info:</label>
                <input type="text" name="infoFournisseur" id="editInfoFournisseur" value="${ressourceToEdit.infoFournisseur}" class="w-full p-2 border rounded-md">
                <span id="editInfoFournisseurError" class="text-red-500 text-sm hidden">Supplier info is required</span>
            </div>
            <button type="submit" class="bg-green-500 text-white p-2 rounded-md hover:bg-green-600">Update Resource</button>
        </form>
    </c:if>
</div>

<script>
    // Validation for Add Form
    function validateAddForm() {
        document.querySelectorAll('#addResourceForm .text-red-500').forEach(error => error.classList.add('hidden'));

        let isValid = true;

        const nom = document.getElementById('addNom').value.trim();
        const type = document.getElementById('addType').value.trim();
        const quantite = parseInt(document.getElementById('addQuantite').value);
        const infoFournisseur = document.getElementById('addInfoFournisseur').value.trim();

        if (!nom) {
            document.getElementById('addNomError').classList.remove('hidden');
            isValid = false;
        }
        if (!type) {
            document.getElementById('addTypeError').classList.remove('hidden');
            isValid = false;
        }
        if (isNaN(quantite) || quantite <= 0) {
            document.getElementById('addQuantiteError').classList.remove('hidden');
            isValid = false;
        }
        if (!infoFournisseur) {
            document.getElementById('addInfoFournisseurError').classList.remove('hidden');
            isValid = false;
        }

        return isValid;
    }

    // Validation for Edit Form
    function validateEditForm() {
        document.querySelectorAll('#editResourceForm .text-red-500').forEach(error => error.classList.add('hidden'));

        let isValid = true;

        const nom = document.getElementById('editNom').value.trim();
        const type = document.getElementById('editType').value.trim();
        const quantite = parseInt(document.getElementById('editQuantite').value);
        const infoFournisseur = document.getElementById('editInfoFournisseur').value.trim();

        if (!nom) {
            document.getElementById('editNomError').classList.remove('hidden');
            isValid = false;
        }
        if (!type) {
            document.getElementById('editTypeError').classList.remove('hidden');
            isValid = false;
        }
        if (isNaN(quantite) || quantite <= 0) {
            document.getElementById('editQuantiteError').classList.remove('hidden');
            isValid = false;
        }
        if (!infoFournisseur) {
            document.getElementById('editInfoFournisseurError').classList.remove('hidden');
            isValid = false;
        }

        return isValid;
    }

    document.addEventListener('DOMContentLoaded', function() {
        const addForm = document.getElementById('addResourceForm');
        addForm.addEventListener('submit', function(e) {
            if (!validateAddForm()) {
                e.preventDefault();
            }
        });

        const editForm = document.getElementById('editResourceForm');
        if (editForm) {
            editForm.addEventListener('submit', function(e) {
                if (!validateEditForm()) {
                    e.preventDefault();
                }
            });
        }
    });
</script>
</body>
</html>