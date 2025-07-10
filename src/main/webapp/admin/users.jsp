<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	var ctx = request.getContextPath();
	var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
	var appName = (String) application.getAttribute("AppName");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Utilisateurs - <%=appName%> Admin</title>
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		:root {
			--main-bg1: #43cea2;
			--main-bg2: #185a9d;
			--brand-gradient: linear-gradient(135deg, var(--main-bg2), var(--main-bg1));
			--brand-gradient-reverse: linear-gradient(135deg, var(--main-bg1), var(--main-bg2));
			--accent-color: #ffd600;
			--glass-bg: rgba(255,255,255,0.13);
		}
		body {
			font-family: 'Inter', sans-serif;
			background: var(--brand-gradient),
			url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:%2343cea2;stop-opacity:1" /><stop offset="100%" style="stop-color:%23185a9d;stop-opacity:1" /></linearGradient></defs><rect width="1000" height="1000" fill="url(%23bg)"/><g opacity="0.08"><circle cx="200" cy="200" r="100" fill="white"/><circle cx="800" cy="300" r="150" fill="white"/><circle cx="400" cy="700" r="80" fill="white"/><circle cx="700" cy="800" r="120" fill="white"/><rect x="100" y="500" width="200" height="100" rx="10" fill="white"/><rect x="600" y="100" width="250" height="120" rx="15" fill="white"/></g></svg>');
			background-size: cover;
			background-attachment: fixed;
			min-height: 100vh;
			color: #fff;
		}
		body::before {
			content: '';
			position: fixed; top: 0; left: 0; right: 0; bottom: 0;
			background-image:
					radial-gradient(circle at 20% 20%, rgba(255,255,255,0.06) 1px, transparent 1px),
					radial-gradient(circle at 80% 30%, rgba(255,255,255,0.04) 1px, transparent 1px),
					radial-gradient(circle at 40% 70%, rgba(255,255,255,0.04) 1px, transparent 1px),
					radial-gradient(circle at 90% 80%, rgba(255,255,255,0.06) 1px, transparent 1px);
			background-size: 200px 200px,300px 300px,250px 250px,180px 180px;
			animation: float 20s infinite linear;
			pointer-events: none;
			z-index: 1;
		}
		@keyframes float {
			0%   { transform: translate(0,0);}
			25%  { transform: translate(5px,-10px);}
			50%  { transform: translate(-5px,-5px);}
			75%  { transform: translate(3px,-15px);}
			100% { transform: translate(0,0);}
		}
		.navbar {
			background: rgba(255,255,255,0.13) !important;
			backdrop-filter: blur(16px);
			border-bottom: 1px solid rgba(255,255,255,0.13);
		}
		.navbar-brand { font-weight: 700; font-size: 1.3rem; }
		.nav-link {
			color: #fff !important;
			font-weight: 500;
			border-radius: 10px;
			margin: 0 .2rem;
			transition: all 0.3s;
		}
		.nav-link:hover, .nav-link.active {
			background: rgba(255,255,255,0.19) !important;
			color: #fff !important;
			transform: translateY(-2px);
		}
		.dropdown-menu { background: rgba(255,255,255,0.97) !important; border-radius: 12px;}
		.dropdown-item:hover { background: rgba(67,206,162,0.15) !important; color: #43cea2 !important; }

		.page-title {
			font-size: 2.25rem; font-weight: 700;
			color: #ffd600;
			text-shadow: 0 2px 10px rgba(0,0,0,0.17);
			margin-bottom: 2rem; text-align: center;
		}
		.dashboard-card {
			background: var(--glass-bg);
			backdrop-filter: blur(16px);
			border: 1px solid rgba(255,255,255,0.14);
			border-radius: 19px;
			box-shadow: 0 10px 32px rgba(67,206,162,0.11);
			position: relative; transition: .25s;
			z-index: 10; animation: slideUp 0.6s; opacity: 0;
		}
		.dashboard-card:hover {
			background: rgba(67,206,162,0.13);
			border-color: rgba(255,255,255,0.21);
			box-shadow: 0 18px 50px rgba(67,206,162,0.18);
			transform: translateY(-7px) scale(1.014);
		}
		@keyframes slideUp { to {opacity:1;transform:translateY(0);} from {opacity:0;transform:translateY(30px);} }
		/* ---- TABLE ---- */
		.glass-table {
			background: var(--glass-bg);
			backdrop-filter: blur(10px);
			border-radius: 16px; overflow: hidden;
			margin-bottom: 1.5rem;
		}
		.glass-table thead { background: rgba(255,255,255,0.16);}
		.glass-table th {
			color: #fff !important;
			font-weight: 600; padding: 15px 10px; border: none;
			text-transform: uppercase;
			letter-spacing: 0.5px; text-shadow: 0 1px 5px rgba(0,0,0,0.2);
		}
		.glass-table td {
			color: #fff !important; padding: 14px 10px; border: none;
			border-bottom: 1px solid rgba(255,255,255,0.11); vertical-align: middle; font-weight: 500;
		}
		.glass-table tbody tr { transition: all 0.3s;}
		.glass-table tbody tr:hover { background: rgba(255,255,255,0.13); transform: translateY(-2px);}
		/* -- Actions -- */
		.action-btn {
			border: none; border-radius: 12px; padding: 7px 12px; transition: all 0.3s;
			font-weight: 500; margin: 0 2px; color: white !important; display: inline-block;
			background: linear-gradient(135deg, #ffd600 30%, #43cea2 100%);
		}
		.action-btn.btn-edit { background: linear-gradient(135deg, #ffc107, #43cea2);}
		.action-btn.btn-delete { background: linear-gradient(135deg, #dc3545, #b02a37);}
		.action-btn:hover { transform: translateY(-2px) scale(1.09); box-shadow: 0 4px 16px rgba(0,0,0,0.19);}
		/* --- Formulaire glass --- */
		.form-container {
			background: var(--glass-bg);
			backdrop-filter: blur(10px);
			border-radius: 17px; padding: 28px 20px;
			box-shadow: 0 8px 24px rgba(67,206,162,0.11);
		}
		.form-title {
			color: #ffd600;
			font-weight: 600; text-align: center; margin-bottom: 18px; font-size: 1.25rem;
			text-shadow: 0 1px 6px rgba(0,0,0,0.12);
		}
		.input-group { background: rgba(255,255,255,0.9); border-radius: 10px; overflow: hidden; border: 1px solid rgba(255,255,255,0.3);}
		.input-group:focus-within { border-color: #43cea2; box-shadow: 0 0 15px rgba(67,206,162,0.15); transform: translateY(-1px);}
		.input-group-text { background: rgba(0,102,204,0.07) !important; border: none; color: #185a9d;}
		.form-control, .form-select { border: none; background: transparent; font-weight: 500; padding: 12px 14px; color: #333;}
		.form-control:focus, .form-select:focus { border: none; box-shadow: none;}
		.role-badge { padding: 7px 13px; border-radius: 18px; font-size: 0.87rem; font-weight: 600; text-transform: uppercase;}
		.role-admin { background: linear-gradient(135deg, #dc3545, #b02a37); color: white;}
		.role-user  { background: linear-gradient(135deg, #43cea2, #185a9d); color: white;}
		.btn-submit {
			background: linear-gradient(135deg, #28a745, #20c997);
			border: none; border-radius: 12px; padding: 12px 30px;
			font-weight: 600; color: white; transition: all 0.3s;
		}
		.btn-submit:hover {
			transform: translateY(-2px); box-shadow: 0 8px 25px rgba(40,167,69,0.34); color: white;
		}
		footer {
			background: rgba(255,255,255,0.06);
			border-top: 1px solid rgba(255,255,255,0.13);
			margin-top: 3.5rem; padding: 2rem 0 1.1rem 0;
			text-align: center; color: rgba(255,255,255,0.74);
		}
		@media (max-width: 1020px) {
			.dashboard-card { margin-bottom: 1.7rem;}
		}
		@media (max-width: 800px) {
			.page-title { font-size: 1.4rem;}
			.glass-table, .form-container { font-size: 0.96rem;}
			.dashboard-card { margin-bottom: 1.1rem;}
		}
	</style>
</head>

<body>
<!-- NAVBAR IDENTIQUE -->
<nav class="navbar navbar-expand-lg navbar-dark shadow">
	<div class="container-fluid">
		<a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
			<img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="me-2">
			<strong class="text-white"><%=appName%> Admin</strong>
		</a>
		<div class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link text-white fw-bold" href="<%= ctx %>/home">
						<i class="bi bi-speedometer2 me-1"></i> Tableau de bord
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-white fw-bold active" href="<%= ctx %>/users">
						<i class="bi bi-people-fill me-1"></i> Utilisateurs
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-white fw-bold" href="<%= ctx %>/credit-requests">
						<i class="bi bi-credit-card me-1"></i> Demandes de crédit
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-white fw-bold" href="<%= ctx %>/reports">
						<i class="bi bi-graph-up me-1"></i> Rapports
					</a>
				</li>
			</ul>
		</div>
		<div class="dropdown d-flex align-items-center">
			<a class="btn btn-outline-light dropdown-toggle"
			   href="#" role="button" id="dropdownSessionMenu" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="bi bi-person-circle me-1"></i> <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
			</a>
			<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownSessionMenu">
				<li><a class="dropdown-item" href="<%= ctx %>/admin/profile"><i class="bi bi-person me-1"></i> Mon profil</a></li>
				<li><a class="dropdown-item" href="<%= ctx %>/admin/settings"><i class="bi bi-gear me-1"></i> Paramètres</a></li>
				<li><hr class="dropdown-divider"></li>
				<li>
					<a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
						<i class="bi bi-box-arrow-right me-1"></i> Déconnexion
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>

<div class="container-fluid mt-4 main-container">
	<div class="row mb-4">
		<div class="col-12">
			<h1 class="page-title">
				<i class="bi bi-people-fill me-2"></i>
				Gestion des Utilisateurs
			</h1>
		</div>
	</div>
	<div class="row mb-4">
		<div class="col-lg-8 col-md-12 mb-4">
			<div class="dashboard-card">
				<div class="card-body p-0">
					<div class="glass-table">
						<table class="table table-hover mb-0">
							<thead>
							<tr>
								<th class="text-center"><i class="bi bi-person me-1"></i>Nom</th>
								<th class="text-center"><i class="bi bi-person-badge me-1"></i>Prénom</th>
								<th class="text-center"><i class="bi bi-person-circle me-1"></i>Login</th>
								<th class="text-center"><i class="bi bi-shield-lock me-1"></i>Rôle</th>
								<th class="text-center"><i class="bi bi-gear me-1"></i>Actions</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td class="text-center fw-bold">${user.lastName}</td>
									<td class="text-center fw-bold">${user.firstName}</td>
									<td class="text-center">${user.username}</td>
									<td class="text-center">
                                        <span class="role-badge ${user.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
												${user.role}
										</span>
									</td>
									<td class="text-center">
										<a href="${pageContext.request.contextPath}/users/edit?id=${user.id}"
										   class="action-btn btn-edit">
											<i class="bi bi-pencil-fill"></i>
										</a>
										<a href="${pageContext.request.contextPath}/users/delete?id=${user.id}"
										   class="action-btn btn-delete">
											<i class="bi bi-trash-fill"></i>
										</a>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- Formulaire à droite -->
		<div class="col-lg-4 col-md-12">
			<div class="dashboard-card">
				<div class="card-body">
					<div class="form-container">
						<h2 class="form-title">
							<c:choose>
								<c:when test="${not empty user}">
									<i class="bi bi-pencil-square me-2"></i>
									Modifier un utilisateur
								</c:when>
								<c:otherwise>
									<i class="bi bi-person-plus me-2"></i>
									Ajouter un nouvel utilisateur
								</c:otherwise>
							</c:choose>
						</h2>
						<c:if test="${not empty user}">
							<div class="text-center mb-3">
								<a href="${pageContext.request.contextPath}/users" class="btn btn-outline-light fw-bold">
									<i class="bi bi-person-plus-fill me-1"></i> Ajouter un nouvel utilisateur
								</a>
							</div>
						</c:if>
						<form action="${pageContext.request.contextPath}/users/save" method="post">
							<input type="hidden" name="id" value="${user.id}"/>
							<div class="form-group">
								<div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-badge"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="firstName"
										   placeholder="Prénom" value="${user.firstName}" required/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="lastName"
										   placeholder="Nom" value="${user.lastName}" required/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-circle"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="username"
										   placeholder="Nom d'utilisateur" value="${user.username}" required/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock-fill"></i>
                                    </span>
									<input type="password" class="form-control fw-bold" name="password"
										   placeholder="Mot de passe" value="${user.password}" required/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="bi bi-shield-lock"></i>
                                    </span>
									<select name="role" class="form-select fw-bold" required>
										<option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
										<option value="USER"  ${user.role == 'USER'  ? 'selected' : ''}>USER</option>
									</select>
								</div>
							</div>
							<div class="text-center mt-4">
								<button type="submit" class="btn-submit">
									<i class="bi bi-save me-2"></i> Enregistrer
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<footer class="shadow-sm py-4">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-md-6">
                <span class="text-muted">
                    <strong style="color: #ffd600;"><%= appName %></strong> Admin Panel © 2025 - Tous droits réservés
                </span>
			</div>
			<div class="col-md-6 text-end">
				<small class="text-muted">Version 2.1.5 | Dernière connexion: <%= new java.util.Date() %></small>
			</div>
		</div>
	</div>
</footer>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const cards = document.querySelectorAll('.dashboard-card');
		cards.forEach((card, index) => {
			setTimeout(() => {
				card.style.opacity = '1';
				card.style.transform = 'translateY(0)';
			}, index * 230);
		});
		const rows = document.querySelectorAll('.glass-table tbody tr');
		rows.forEach((row, index) => {
			row.style.opacity = '0';
			row.style.transform = 'translateY(17px)';
			setTimeout(() => {
				row.style.transition = 'all 0.5s';
				row.style.opacity = '1';
				row.style.transform = 'translateY(0)';
			}, 600 + (index * 100));
		});
		const actionBtns = document.querySelectorAll('.action-btn');
		actionBtns.forEach(btn => {
			btn.addEventListener('mouseenter', function() {
				const icon = this.querySelector('i');
				icon.style.transform = 'scale(1.2) rotate(5deg)';
				icon.style.transition = 'transform 0.3s';
			});
			btn.addEventListener('mouseleave', function() {
				const icon = this.querySelector('i');
				icon.style.transform = 'scale(1) rotate(0deg)';
			});
		});
		const inputs = document.querySelectorAll('.form-control, .form-select');
		inputs.forEach(input => {
			input.addEventListener('focus', function() {
				this.parentElement.style.transform = 'scale(1.02)';
			});
			input.addEventListener('blur', function() {
				this.parentElement.style.transform = 'scale(1)';
			});
		});
	});
</script>
</body>
</html>
