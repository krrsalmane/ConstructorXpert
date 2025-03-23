<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Construction Xpert - Add Resource</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="font-sans bg-gray-50">
<!-- Navbar -->
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

<!-- Form Section -->
<section class="container mx-auto px-6 py-20">
    <div class="max-w-lg mx-auto bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600">
        <h2 class="text-2xl font-bold text-green-800 mb-6">Add Resource for Task #${param.taskId}</h2>
        <form id="resourceForm" action="ressource" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="taskId" value="${param.taskId}">
            <div class="mb-4">
                <label for="nom" class="block text-gray-700 font-medium mb-2">Name</label>
                <input type="text" id="nom" name="nom" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="nomError" class="text-red-500 text-sm hidden">Name is required and must contain only letters and spaces</span>
            </div>
            <div class="mb-4">
                <label for="type" class="block text-gray-700 font-medium mb-2">Type</label>
                <input type="text" id="type" name="type" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="typeError" class="text-red-500 text-sm hidden">Type is required</span>
            </div>
            <div class="mb-4">
                <label for="quantite" class="block text-gray-700 font-medium mb-2">Quantity</label>
                <input type="number" id="quantite" name="quantite" class="w-full p-3 border border-green-600 rounded-lg" min="1">
                <span id="quantiteError" class="text-red-500 text-sm hidden">Quantity is required and must be positive</span>
            </div>
            <div class="mb-4">
                <label for="infoFournisseur" class="block text-gray-700 font-medium mb-2">Supplier Info</label>
                <input type="text" id="infoFournisseur" name="infoFournisseur" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="infoFournisseurError" class="text-red-500 text-sm hidden">Supplier info is optional but must be valid if provided</span>
            </div>
            <div class="mb-6">
                <label for="quantiteAssignee" class="block text-gray-700 font-medium mb-2">Assigned Quantity</label>
                <input type="number" id="quantiteAssignee" name="quantiteAssignee" class="w-full p-3 border border-green-600 rounded-lg" min="1">
                <span id="quantiteAssigneeError" class="text-red-500 text-sm hidden">Assigned quantity is required and must be positive and less than or equal to total quantity</span>
            </div>
            <div class="flex justify-end space-x-4">
                <a href="ressource?taskId=${param.taskId}" class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100">Cancel</a>
                <button type="submit" class="px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 shadow-md">Add Resource</button>
            </div>
        </form>
    </div>
</section>

<!-- Footer -->
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

<!-- Validation Script -->
<script>
    function validateForm() {
        // Hide all error messages initially
        document.querySelectorAll('#resourceForm .text-red-500').forEach(error => error.classList.add('hidden'));
        let isValid = true;

        // Get form values
        const nom = document.getElementById('nom').value.trim();
        const type = document.getElementById('type').value.trim();
        const quantite = parseInt(document.getElementById('quantite').value);
        const infoFournisseur = document.getElementById('infoFournisseur').value.trim();
        const quantiteAssignee = parseInt(document.getElementById('quantiteAssignee').value);

        // Validation rules
        const nomRegex = /^[a-zA-Z\s]+$/;
        if (!nom || !nomRegex.test(nom)) {
            document.getElementById('nomError').classList.remove('hidden');
            isValid = false;
        }

        if (!type) {
            document.getElementById('typeError').classList.remove('hidden');
            isValid = false;
        }

        if (isNaN(quantite) || quantite <= 0) {
            document.getElementById('quantiteError').classList.remove('hidden');
            isValid = false;
        }

        // Supplier info is optional, but if provided, it should be valid (e.g., no special chars for simplicity)
        const infoRegex = /^[a-zA-Z0-9\s]*$/;
        if (infoFournisseur && !infoRegex.test(infoFournisseur)) {
            document.getElementById('infoFournisseurError').classList.remove('hidden');
            isValid = false;
        }

        if (isNaN(quantiteAssignee) || quantiteAssignee <= 0 || (quantite && quantiteAssignee > quantite)) {
            document.getElementById('quantiteAssigneeError').classList.remove('hidden');
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>