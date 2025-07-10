<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%
    var ctx = request.getContextPath();
    var result = (MoneyData) request.getAttribute("result");
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");

    // Données fictives pour la démo
    var totalUsers = request.getAttribute("totalUsers") != null ? (Integer) request.getAttribute("totalUsers") : 245;
    var pendingCreditRequests = request.getAttribute("pendingCreditRequests") != null ? (Integer) request.getAttribute("pendingCreditRequests") : 12;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord - Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS IMPORTS -->
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, rgba(0, 32, 96, 0.97), rgba(0, 200, 180, 0.81));
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            color: #fff;
        }
        body::before {
            content: '';
            position: fixed; top:0; left:0; right:0; bottom:0;
            background-image:
                    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.07) 1px, transparent 1px),
                    radial-gradient(circle at 80% 30%, rgba(255,255,255,0.08) 1px, transparent 1px),
                    radial-gradient(circle at 40% 70%, rgba(255,255,255,0.07) 1px, transparent 1px),
                    radial-gradient(circle at 90% 80%, rgba(255,255,255,0.08) 1px, transparent 1px);
            background-size: 200px 200px,300px 300px,250px 250px,180px 180px;
            animation: float 20s infinite linear;
            pointer-events: none;
            z-index: 1;
        }
        @keyframes float {
            0% { transform: translate(0,0);}
            25% { transform: translate(5px,-10px);}
            50% { transform: translate(-5px,-5px);}
            75% { transform: translate(3px,-15px);}
            100%{ transform: translate(0,0);}
        }
        /* --- NAVBAR --- */
        .navbar {
            background: rgba(255,255,255,0.13) !important;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.3rem;
        }
        .nav-link {
            color: #fff !important;
            font-weight: 500;
            border-radius: 10px;
            margin: 0 .2rem;
            transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.17) !important;
            color: #fff !important;
            transform: translateY(-2px);
        }
        .dropdown-menu {
            background: rgba(255,255,255,0.95) !important;
            border-radius: 12px;
        }
        .dropdown-item:hover {
            background: rgba(0,180,180,0.12) !important;
            color: #009fbe !important;
        }
        /* --- HEADER ADMIN --- */
        .admin-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1.2rem;
            flex-wrap: wrap;
            margin: 2rem 0 2.5rem 0;
        }
        .admin-avatar {
            width: 68px; height: 68px;
            background: linear-gradient(135deg,#00c8b4 70%,#002060 100%);
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 8px 25px rgba(0,200,180,0.18);
            font-size: 2.2rem;
            color: #fff;
            position: relative;
        }
        .admin-badge {
            position: absolute;
            bottom: -6px; right: -6px;
            background: linear-gradient(135deg, #ffc107, #ff7b3a);
            color: #002060;
            font-size: 0.80rem;
            padding: 3px 10px;
            border-radius: 20px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.17);
        }
        .admin-header-info {
            text-align: left;
        }
        .welcome-title {
            font-size: 2.3rem;
            font-weight: 700;
            margin-bottom: .2rem;
            text-shadow: 0 2px 12px rgba(0,0,0,0.12);
            color: #fff;
        }
        .welcome-subtitle {
            color: rgba(255,255,255,0.84);
            font-size: 1.07rem;
        }
        /* --- STAT CARDS --- */
        .dashboard-card {
            background: rgba(255,255,255,0.15);
            border-radius: 24px;
            box-shadow: 0 10px 38px 0 rgba(0,200,180,0.08);
            border: 1.5px solid rgba(255,255,255,0.18);
            transition: .25s;
            opacity: 0;
            animation: slideUp 0.7s ease-out;
        }
        .dashboard-card:hover {
            background: rgba(0,180,180,0.16);
            box-shadow: 0 17px 60px 0 rgba(0,200,180,0.18);
            border-color: rgba(0,200,180,0.23);
            transform: translateY(-6px) scale(1.015);
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(35px);}
            to { opacity: 1; transform: translateY(0);}
        }
        .stat-number {
            font-size: 2.15rem;
            font-weight: 700;
            color: #fff;
            text-shadow: 0 2px 10px rgba(0,0,0,0.14);
        }
        .stat-label {
            font-size: 1rem;
            color: rgba(255,255,255,0.76);
            font-weight: 600;
            letter-spacing: .5px;
        }
        .bg-gradient-primary {
            background: linear-gradient(135deg,#00c8b4 60%,#002060 100%) !important;
        }
        .bg-gradient-success {
            background: linear-gradient(135deg,#27e98a 60%,#00525e 100%) !important;
        }
        .bg-gradient-warning {
            background: linear-gradient(135deg,#ffc107,#ff7b3a) !important;
        }
        .card-title { color: #fff !important; }
        /* --- QUICK ACTIONS --- */
        .quick-action-btn {
            background: rgba(255,255,255,0.13) !important;
            border-radius: 18px;
            padding: 1.1rem 1.3rem;
            color: #fff !important;
            margin: .3rem 0;
            transition: all .23s;
            border: 1.2px solid rgba(255,255,255,0.12);
            text-decoration: none;
            display: block;
        }
        .quick-action-btn:hover {
            background: rgba(0,180,180,0.19) !important;
            border-color: rgba(0,180,180,0.22) !important;
            color: #fff !important;
            transform: translateY(-3px) scale(1.017);
            box-shadow: 0 6px 18px rgba(0,180,180,0.13);
        }
        /* --- Section titles --- */
        .section-title {
            margin: 2.3rem 0 1.2rem 0;
            color: #00c8b4;
            font-weight: 700;
            font-size: 1.32rem;
            letter-spacing: .5px;
            text-shadow: 0 2px 8px rgba(0,200,180,0.09);
        }
        .section-divider {
            border: none;
            border-top: 2px solid #00c8b4;
            opacity: .25;
            margin: 1.5rem 0;
        }
        /* --- Footer --- */
        footer {
            background: rgba(255,255,255,0.08);
            border-top: 1px solid rgba(255,255,255,0.10);
            color: rgba(255,255,255,0.78);
            font-size: 1rem;
        }
        @media (max-width: 800px) {
            .welcome-title { font-size: 1.5rem;}
            .admin-header { flex-direction: column;}
            .dashboard-card { margin-bottom: 1.1rem;}
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark shadow">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="me-2">
            <strong class="text-white"><%= appName %> Admin</strong>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/home">
                        <i class="bi bi-speedometer2 me-1"></i> Tableau de bord
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/users">
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
                <i class="bi bi-person-circle me-1"></i>
                <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
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

<!-- HEADER ADMIN PERSONNALISÉ -->
<div class="container admin-header">
    <div class="admin-avatar position-relative">
        <i class="bi bi-shield-lock-fill"></i>
        <span class="admin-badge">ADMIN</span>
    </div>
    <div class="admin-header-info">
        <div class="welcome-title">Bienvenue, <%= connectedUser.getFirstName() %> !</div>
        <div class="welcome-subtitle">Votre tableau de bord administrateur de <b><%= appName %></b>.</div>
    </div>
</div>

<!-- SECTION STATS -->
<div class="container">
    <div class="section-title">Statistiques Système</div>
    <hr class="section-divider"/>
    <div class="row mb-5">
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-primary text-white h-100">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="stat-label mb-2">Solde Total Système</div>
                            <div class="stat-number"><%= result != null ? result.toString() : "0 MAD" %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-wallet2" style="font-size: 2.5rem; opacity: 0.8;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-success text-white h-100">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="stat-label mb-2">Utilisateurs Actifs</div>
                            <div class="stat-number"><%= totalUsers %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people-fill" style="font-size: 2.5rem; opacity: 0.8;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-warning text-white h-100">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="stat-label mb-2">Demandes en Attente</div>
                            <div class="stat-number"><%= pendingCreditRequests %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-credit-card" style="font-size: 2.5rem; opacity: 0.8;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- SECTION ACTIONS RAPIDES -->
<div class="container">
    <div class="section-title">Actions Rapides</div>
    <hr class="section-divider"/>
    <div class="card dashboard-card mb-5">
        <div class="card-body p-4">
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="<%= ctx %>/users" class="quick-action-btn text-start">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-people-fill me-3" style="font-size: 1.5rem;"></i>
                            <div>
                                <strong class="d-block">Gestion Utilisateurs</strong>
                                <small class="text-muted">Voir, ajouter, modifier les comptes</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="<%= ctx %>/credit-requests" class="quick-action-btn text-start">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-credit-card me-3" style="font-size: 1.5rem;"></i>
                            <div>
                                <strong class="d-block">Demandes de Crédit</strong>
                                <small class="text-muted">Gérer et approuver les demandes</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="<%= ctx %>/reports" class="quick-action-btn text-start">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-graph-up me-3" style="font-size: 1.5rem;"></i>
                            <div>
                                <strong class="d-block">Rapports & Analytics</strong>
                                <small class="text-muted">Statistiques et analyses</small>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="shadow-sm py-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <span class="text-muted">
                    <strong style="color: #fff;"><%= appName %></strong> Admin Panel © 2025 - Tous droits réservés
                </span>
            </div>
            <div class="col-md-6 text-end">
                <small class="text-muted">Version 2.1.5 | Dernière connexion: <%= new java.util.Date() %></small>
            </div>
        </div>
    </div>
</footer>
<script>
    // Animation d’apparition des cartes admin
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.dashboard-card').forEach((card, i) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, i * 200);
        });
    });
</script>
</body>
</html>
