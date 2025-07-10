<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  var ctx = request.getContextPath();
  var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mes Demandes de Crédit | Bankati</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(120deg, #193A6B 50%, #1DE9B6 100%);
      min-height: 100vh;
      color: #fff;
      margin: 0;
    }
    .navbar {
      background: rgba(25, 58, 107, 0.92) !important;
      border-bottom: 2px solid rgba(255,255,255,0.05);
      box-shadow: 0 4px 24px 0 #1de9b630;
    }
    .navbar-brand {
      font-weight: 700;
      letter-spacing: .5px;
      font-size: 1.2rem;
    }
    /* HEADER HERO */
    .credit-hero {
      background: linear-gradient(120deg,#193A6B 60%,#1DE9B6 120%);
      border-radius: 0 0 2.5rem 2.5rem;
      box-shadow: 0 8px 30px #1de9b626;
      padding: 2.7rem 0 2.1rem 0;
      margin-bottom: 2.3rem;
      text-align: center;
      position: relative;
    }
    .credit-hero h1 {
      font-size: 2.7rem;
      font-weight: 800;
      letter-spacing: .8px;
      color: #fff;
      margin-bottom: .6rem;
      text-shadow: 0 4px 20px #1de9b640;
      animation: fadeUp .8s cubic-bezier(.22,1,.36,1) both;
    }
    .credit-hero p {
      color: #b8fff6;
      font-size: 1.2rem;
      font-weight: 500;
      margin-bottom: 0;
      animation: fadeUp .9s .08s both;
    }
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(40px);}
      to { opacity: 1; transform: translateY(0);}
    }
    /* GLASS CARD */
    .glass-card {
      background: rgba(255,255,255,0.13);
      border-radius: 25px;
      box-shadow: 0 10px 32px 0 #193a6b2a;
      border: 1.6px solid rgba(255,255,255,0.17);
      margin-bottom: 2.6rem;
      overflow: hidden;
      backdrop-filter: blur(8px);
      position: relative;
      animation: fadeUp .7s cubic-bezier(.22,1,.36,1) both;
      opacity: 0;
    }
    .glass-card.appear { opacity: 1;}
    .glass-card .card-header {
      background: linear-gradient(90deg, #1DE9B6 8%, #193A6B 120%);
      color: #fff;
      font-weight: 700;
      border-bottom: 1px solid rgba(255,255,255,0.11);
      font-size: 1.12rem;
      padding: 1.3rem 2rem;
      letter-spacing: .4px;
      border-radius: 25px 25px 0 0 !important;
      box-shadow: 0 2px 14px #1de9b614;
    }
    /* FORMULAIRE */
    .form-label {
      color: #1DE9B6;
      font-weight: 600;
    }
    .form-control {
      background: rgba(255,255,255,0.14);
      border: 1.5px solid #1de9b659;
      color: #fff;
      border-radius: 13px;
      font-size: 1.05rem;
      transition: .2s;
    }
    .form-control:focus {
      background: rgba(255,255,255,0.18);
      border-color: #1DE9B6;
      color: #fff;
      box-shadow: 0 0 10px #1de9b652;
    }
    .btn-gradient {
      background: linear-gradient(90deg, #1DE9B6 40%, #193A6B 100%);
      border: none;
      border-radius: 16px;
      font-weight: 700;
      font-size: 1.13rem;
      color: #fff;
      padding: .85rem 2.2rem;
      margin-top: 12px;
      box-shadow: 0 4px 18px #1de9b620;
      transition: .2s;
    }
    .btn-gradient:hover {
      background: linear-gradient(90deg, #193A6B 10%, #1DE9B6 100%);
      transform: scale(1.03) translateY(-1px);
    }
    /* TABLEAU HISTORIQUE */
    .table {
      color: #fff;
      border-radius: 13px;
      background: none;
      font-size: 1.04rem;
      overflow: hidden;
    }
    .table thead th {
      background: rgba(30,210,176,0.18);
      color: #1DE9B6;
      border: none;
      font-weight: 600;
      padding-top: 1rem;
      padding-bottom: 1rem;
      letter-spacing: .5px;
    }
    .table-hover tbody tr {
      transition: background .18s, box-shadow .18s;
    }
    .table-hover tbody tr:hover {
      background: rgba(25,58,107,0.09);
      box-shadow: 0 2px 12px #1de9b615;
      scale: 1.009;
    }
    /* BADGES ETATS */
    .status-badge {
      padding: 7px 18px;
      border-radius: 2rem;
      font-size: .99rem;
      font-weight: 700;
      letter-spacing: .2px;
      display: inline-flex;
      align-items: center;
      gap: .55rem;
      box-shadow: 0 2px 12px #1de9b613;
    }
    .status-pending {background: #fffbe8a9; color: #ffc107;}
    .status-approved {background: #18fa9c9a; color: #10b57a;}
    .status-rejected {background: #ffbdbda2; color: #dc3545;}
    .badge {
      background: #1DE9B6;
      color: #193A6B;
      font-weight: 700;
      padding: 7px 15px;
      border-radius: 1.6rem;
      font-size: 1rem;
      box-shadow: 0 1px 7px #1de9b620;
    }
    /* ACTIONS */
    .action-btn {
      border-radius: 14px;
      border: none;
      background: none;
      color: #fff;
      padding: 7px 15px;
      margin: 0 2px;
      font-size: 1rem;
      transition: .18s;
      opacity: .93;
    }
    .action-btn:hover { opacity: 1; background: #193a6b15;}
    .action-btn.text-success:hover { color: #10b57a;}
    .action-btn.text-danger:hover { color: #dc3545;}
    .action-btn.text-secondary:hover { color: #6c757d;}
    /* EMPTY */
    .empty-state {
      text-align: center;
      color: #b8fff6;
      opacity: .75;
      font-size: 1.11rem;
      padding: 2.3rem 1.2rem;
    }
    .empty-state i {font-size: 2.5rem;}
    /* FOOTER */
    .footer {
      background: rgba(255,255,255,0.05);
      border-top: 1px solid rgba(255,255,255,0.10);
      color: #b8fffa;
      padding: 1.6rem 0 .8rem 0;
      margin-top: 3.2rem;
      text-align: center;
      font-size: 1rem;
    }
    @media (max-width: 900px) {
      .credit-hero h1 { font-size: 2rem;}
      .glass-card .card-header { font-size: 1rem;}
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark shadow sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
      <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="38" class="me-2"> <span>Bankati</span>
    </a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link text-white" href="<%= ctx %>/home"><i class="bi bi-house"></i> Accueil</a></li>
        <li class="nav-item"><a class="nav-link text-white active" href="<%= ctx %>/credit"><i class="bi bi-bank2"></i> Mes crédits</a></li>
      </ul>
      <div class="dropdown d-flex align-items-center">
        <a class="btn btn-outline-light dropdown-toggle" href="#" id="dropdownUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-person-circle"></i> <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
        </a>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUserMenu">
          <li><span class="dropdown-item-text fw-bold text-primary"><%= connectedUser.getRole() %></span></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Mon profil</a></li>
          <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Paramètres</a></li>
          <li><hr class="dropdown-divider"></li>
          <li>
            <a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
              <i class="bi bi-box-arrow-right"></i> Déconnexion
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<!-- HERO HEADER -->
<div class="credit-hero">
  <h1><i class="bi bi-credit-card"></i> Mes demandes de crédit</h1>
  <p>Déposez une nouvelle demande, suivez vos crédits en toute simplicité !</p>
</div>

<!-- MAIN CONTENT -->
<div class="container pb-5">

  <!-- Nouvelle demande -->
  <div class="row justify-content-center mb-4">
    <div class="col-lg-7">
      <div class="glass-card appear">
        <div class="card-header"><i class="bi bi-plus-circle me-2"></i> Nouvelle demande de crédit</div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/credit" method="post">
            <input type="hidden" name="action" value="ajouter" />
            <div class="mb-3">
              <label for="montant" class="form-label">Montant demandé (DH)</label>
              <input type="number" name="montant" id="montant" class="form-control" placeholder="ex: 10 000 DH" required step="0.01" min="1000">
              <small class="form-text">Montant minimum : 1 000 DH</small>
            </div>
            <div class="text-end">
              <button type="submit" class="btn-gradient"><i class="bi bi-send-check me-2"></i>Soumettre</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Historique -->
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="glass-card appear">
        <div class="card-header d-flex justify-content-between align-items-center">
          <span><i class="bi bi-clock-history me-2"></i> Historique des demandes</span>
          <span class="badge">${demandes.size()} demandes</span>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead>
              <tr>
                <th class="text-center">ID</th>
                <th>Montant</th>
                <th>Date</th>
                <th class="text-center">État</th>
                <th class="text-center">Actions</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${demandes}" var="demande">
                <tr>
                  <td class="text-center fw-semibold">#${demande.id}</td>
                  <td><span class="fw-semibold">${demande.montant} DH</span></td>
                  <td><small class="text-white-50">${demande.dateDemande}</small></td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${demande.etat == 'EN_ATTENTE'}">
                        <span class="status-badge status-pending"><i class="bi bi-hourglass-split"></i>En attente</span>
                      </c:when>
                      <c:when test="${demande.etat == 'APPROUVEE'}">
                        <span class="status-badge status-approved"><i class="bi bi-check-circle"></i>Approuvée</span>
                      </c:when>
                      <c:when test="${demande.etat == 'REFUSEE'}">
                        <span class="status-badge status-rejected"><i class="bi bi-x-circle"></i>Refusée</span>
                      </c:when>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:if test="${demande.etat == 'EN_ATTENTE'}">
                      <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                        <input type="hidden" name="action" value="supprimer"/>
                        <input type="hidden" name="id" value="${demande.id}"/>
                        <button class="action-btn text-danger" type="submit" title="Annuler">
                          <i class="bi bi-trash"></i>
                        </button>
                      </form>
                      <c:if test="${connectedUser.role == 'ADMIN'}">
                        <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                          <input type="hidden" name="action" value="approuver"/>
                          <input type="hidden" name="id" value="${demande.id}"/>
                          <button class="action-btn text-success" type="submit" title="Approuver">
                            <i class="bi bi-check-lg"></i>
                          </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                          <input type="hidden" name="action" value="refuser"/>
                          <input type="hidden" name="id" value="${demande.id}"/>
                          <button class="action-btn text-secondary" type="submit" title="Refuser">
                            <i class="bi bi-x-lg"></i>
                          </button>
                        </form>
                      </c:if>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty demandes}">
                <tr>
                  <td colspan="5" class="empty-state">
                    <i class="bi bi-emoji-frown"></i>
                    <div>Aucune demande de crédit.</div>
                    <small>Soumettez votre première demande en haut.</small>
                  </td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<footer class="footer">
  <strong>Bankati</strong> © 2025 – Tous droits réservés
</footer>
<script>
  // Animation cards
  document.addEventListener('DOMContentLoaded', function() {
    setTimeout(()=>{
      document.querySelectorAll('.glass-card').forEach(card=>{card.classList.add('appear');});
    }, 120);
  });
</script>
</body>
</html>
