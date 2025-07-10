<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
    var totalUsers = request.getAttribute("totalUsers") != null ? (Integer) request.getAttribute("totalUsers") : 245;
    var totalTransactions = request.getAttribute("totalTransactions") != null ? (Integer) request.getAttribute("totalTransactions") : 1547;
    var monthlyRevenue = request.getAttribute("monthlyRevenue") != null ? (Double) request.getAttribute("monthlyRevenue") : 125000.0;
    var averageTransaction = request.getAttribute("averageTransaction") != null ? (Double) request.getAttribute("averageTransaction") : 3500.0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Rapports - <%= appName %> Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%);
            background-attachment: fixed;
            min-height: 100vh;
            color: #fff;
        }
        .navbar {
            background: rgba(34,44,68,0.85) !important;
            backdrop-filter: blur(24px);
            border-bottom: 2px solid rgba(67,206,162,0.10);
            box-shadow: 0 6px 24px 0 rgba(67, 206, 162, 0.12);
        }
        .navbar-brand { font-weight:700; font-size:1.18rem;}
        .nav-link { color:#fff!important; font-weight:500; border-radius:9px;}
        .nav-link.active, .nav-link:hover { background: rgba(255,255,255,0.14)!important; color: #ffd600 !important; }
        .badge-report {
            background: linear-gradient(90deg, #ffd600 20%, #43cea2 80%);
            color: #1a334e;
            font-weight: 700;
            border-radius: 18px;
            padding: .44em 1.4em;
            font-size: 1rem;
            position: absolute;
            right: 2rem;
            top: 1.2rem;
            z-index: 2;
            box-shadow: 0 2px 15px 0 rgba(255,214,0,0.14);
        }
        .page-title {
            font-size: 2.2rem;
            font-weight: 800;
            text-align: left;
            margin-bottom: 0.12em;
            color: #ffd600;
            letter-spacing: 1px;
        }
        .page-subtitle {
            color: #43cea2;
            font-size: 1.08rem;
            font-weight: 600;
            margin-bottom: 2.6em;
            letter-spacing: .5px;
        }
        /* Cartes circulaires stats */
        .stats-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 35px;
            margin-bottom: 32px;
            justify-content: center;
        }
        .stat-box {
            background: rgba(255,255,255,0.10);
            border-radius: 50%;
            width: 150px;
            height: 150px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 0 8px;
            box-shadow: 0 6px 24px 0 rgba(67,206,162,0.20);
            position: relative;
            animation: slideUp 0.7s cubic-bezier(.68,-0.55,.27,1.55);
            opacity: 0;
        }
        .stat-box .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #ffd600;
            margin-bottom: .15em;
            letter-spacing: 1px;
        }
        .stat-box .stat-label {
            font-size: .97rem;
            font-weight: 500;
            color: #fff;
            opacity: .82;
            text-align: center;
        }
        .stat-box .stat-icon {
            position: absolute;
            top: -20px;
            right: -20px;
            background: linear-gradient(135deg, #ffd600 50%, #43cea2 100%);
            color: #11416c;
            font-size: 2.3rem;
            border-radius: 50%;
            padding: .4em;
            box-shadow: 0 4px 14px 0 rgba(255,214,0,0.11);
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1);}
            50% { transform: scale(1.14);}
            100% { transform: scale(1);}
        }
        @keyframes slideUp { to{opacity:1;transform:translateY(0);} from{opacity:0;transform:translateY(30px);}}
        .report-card {
            background: rgba(255,255,255,0.13);
            border-radius: 22px;
            box-shadow: 0 10px 35px rgba(24,90,157,0.12);
            margin-bottom: 30px;
            transition: all 0.3s;
            opacity: 0;
            animation: slideUp 0.7s cubic-bezier(.68,-0.55,.27,1.55);
        }
        .report-card:hover { transform:translateY(-7px) scale(1.018); }
        .card-header {
            background: rgba(67,206,162,0.07)!important;
            border-bottom: none;
        }
        .card-title { color: #43cea2!important; font-weight: 700; }
        .table-dark { background: rgba(0,0,0,0.11); border-radius: 12px; }
        .table-dark th, .table-dark td { border-color:rgba(255,255,255,0.09); color:rgba(255,255,255,0.98);}
        .btn-action {
            border: none;
            border-radius: 18px;
            padding: 0.65em 1.3em;
            font-weight: 600;
            color: #11416c;
            margin-right: 6px;
            background: linear-gradient(90deg,#ffd600 20%,#43cea2 80%);
            box-shadow: 0 2px 10px 0 rgba(67,206,162,0.10);
            transition: background 0.2s, color 0.2s;
        }
        .btn-action:hover { background: linear-gradient(90deg,#43cea2 20%,#ffd600 80%); color:#1a334e;}
        footer { background: rgba(255,255,255,0.10); border-top: 1px solid rgba(255,255,255,0.13); margin-top: 3.7rem; padding: 2rem 0 1.1rem 0; text-align: center; color: rgba(255,255,255,0.74);}
        @media (max-width:900px){
            .stats-grid{gap:18px;}
            .stat-box{width:120px;height:120px;}
            .badge-report{position:static; display:inline-block; margin-bottom:1rem;}
        }
        @media (max-width:700px){
            .page-title,.page-subtitle{text-align:center;}
            .badge-report{margin:0 auto 1.5rem auto;}
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark shadow position-sticky top-0" style="z-index:1040;">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="38" height="38" class="me-2">
            <strong class="text-white"><%=appName%> Admin</strong>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="<%= ctx %>/home"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="<%= ctx %>/users"><i class="bi bi-people-fill me-1"></i> Utilisateurs</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="<%= ctx %>/credit-requests"><i class="bi bi-credit-card me-1"></i> Crédits</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold active" href="<%= ctx %>/reports"><i class="bi bi-graph-up me-1"></i> Rapports</a></li>
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
                <li><a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout"><i class="bi bi-box-arrow-right me-1"></i> Déconnexion</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="badge-report">Rapports</div>
<div class="container-fluid mt-4 main-container">
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="page-title"><i class="bi bi-bar-chart-steps me-2"></i>Rapports & Analyses</h1>
            <div class="page-subtitle">Vue synthétique et dynamique du système bancaire</div>
            <div class="d-flex justify-content-end flex-wrap mb-3">
                <button class="btn-action"><i class="bi bi-download me-1"></i>Exporter PDF</button>
                <button class="btn-action"><i class="bi bi-printer me-1"></i>Imprimer</button>
            </div>
        </div>
    </div>

    <!-- Statistiques rapides en cartes circulaires -->
    <div class="stats-grid mb-5">
        <div class="stat-box"><span class="stat-icon"><i class="bi bi-person-badge"></i></span><div class="stat-value"><%= totalUsers %></div><div class="stat-label">Utilisateurs</div></div>
        <div class="stat-box"><span class="stat-icon"><i class="bi bi-arrow-repeat"></i></span><div class="stat-value"><%= totalTransactions %></div><div class="stat-label">Transactions</div></div>
        <div class="stat-box"><span class="stat-icon"><i class="bi bi-cash-coin"></i></span><div class="stat-value"><%= String.format("%.0f", monthlyRevenue) %> MAD</div><div class="stat-label">Revenus/mois</div></div>
        <div class="stat-box"><span class="stat-icon"><i class="bi bi-bar-chart-line"></i></span><div class="stat-value"><%= String.format("%.0f", averageTransaction) %> MAD</div><div class="stat-label">Transaction moy.</div></div>
    </div>

    <div class="row mb-4">
        <div class="col-lg-6 mb-4">
            <div class="card report-card">
                <div class="card-header border-bottom-0">
                    <h5 class="card-title mb-0"><i class="bi bi-trophy text-warning me-2"></i>Top 5 Transactions</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-dark table-striped">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Utilisateur</th>
                                <th>Montant</th>
                                <th>Type</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td>24/05/2025</td><td>Ahmed Benali</td><td class="text-success">+150,000 MAD</td><td><span class="badge bg-success">Crédit</span></td></tr>
                            <tr><td>23/05/2025</td><td>Fatima Zahra</td><td class="text-danger">-95,000 MAD</td><td><span class="badge bg-danger">Débit</span></td></tr>
                            <tr><td>22/05/2025</td><td>Mohammed Alami</td><td class="text-success">+85,000 MAD</td><td><span class="badge bg-success">Crédit</span></td></tr>
                            <tr><td>21/05/2025</td><td>Aicha Benali</td><td class="text-danger">-75,000 MAD</td><td><span class="badge bg-danger">Débit</span></td></tr>
                            <tr><td>20/05/2025</td><td>Youssef Kadiri</td><td class="text-success">+65,000 MAD</td><td><span class="badge bg-success">Crédit</span></td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card report-card">
                <div class="card-header border-bottom-0">
                    <h5 class="card-title mb-0"><i class="bi bi-calendar-month text-info me-2"></i>Activité Mensuelle</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-4"><div class="mb-3"><h4 class="text-success">2,847</h4><small class="text-muted">Transactions totales</small></div></div>
                        <div class="col-4"><div class="mb-3"><h4 class="text-warning">47</h4><small class="text-muted">Nouveaux utilisateurs</small></div></div>
                        <div class="col-4"><div class="mb-3"><h4 class="text-info">1.2M MAD</h4><small class="text-muted">Volume total</small></div></div>
                    </div>
                    <hr style="border-color: rgba(255,255,255,0.2);">
                    <div class="row text-center">
                        <div class="col-6"><div class="mb-2"><span class="text-success">↑ 12%</span><small class="text-muted d-block">vs mois dernier</small></div></div>
                        <div class="col-6"><div class="mb-2"><span class="text-success">↑ 8%</span><small class="text-muted d-block">vs année dernière</small></div></div>
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
                <span class="text-muted"><strong style="color: #ffd600;"><%= appName %></strong> Admin Panel © 2025 - Tous droits réservés</span>
            </div>

        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.report-card').forEach((card, i) => {
            setTimeout(()=>{card.style.opacity='1';card.style.transform='translateY(0)';},i*170);
        });
        document.querySelectorAll('.stat-box').forEach((box, i) => {
            setTimeout(()=>{box.style.opacity='1';box.style.transform='translateY(0)';},i*120);
        });
        document.querySelectorAll('.stat-value').forEach(stat=>{
            const text=stat.textContent; const number=parseInt(text.replace(/[^\d]/g,'')); if(!isNaN(number)&&number>0) animateNumber(stat,0,number,2000,text);
        });
    });
    function animateNumber(element,start,end,duration,originalText){
        const isMAD=originalText.includes('MAD'); const startTime=performance.now();
        function updateNumber(currentTime){
            const elapsed=currentTime-startTime;
            const progress=Math.min(elapsed/duration,1);
            const current=Math.round(start+(end-start)*easeOutCubic(progress));
            if(isMAD){element.textContent=current.toLocaleString()+' MAD';}else{element.textContent=current.toLocaleString();}
            if(progress<1){requestAnimationFrame(updateNumber);}
        }
        requestAnimationFrame(updateNumber);
    }
    function easeOutCubic(t){return 1-Math.pow(1-t,3);}
</script>
</body>
</html>
