<?php
session_start();
if (!isset($_SESSION["stagiaire"])) {
    header("location:login.php");
    exit();
}
require '../connexion.php';
$id = $_SESSION["stagiaire"]["id_stg"];
?>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Mes Notes</title>
  <link href="../bootstrap/bootstrap.css" rel="stylesheet">
  <link href="../bootstrap/bootstrap-icons.css" rel="stylesheet">
  <style>
    .header-footer {
      background-color: #007bff;
      color: white;
      padding: 10px;
    }
    .note-box {
      padding: 4px 10px;
      border-radius: 10px;
      color: white;
      font-weight: bold;
      display: inline-block;
    }
    .note-high { background-color: #28a745; }
    .note-low { background-color: #dc3545; }
  </style>
</head>
<body>

<div class="header-footer d-flex justify-content-between px-4">
  <strong>Espace Stagiaire</strong>
  <div>
    <a href="profil.php" class="text-white me-3">Profil</a>
    <a href="notes.php" class="text-white me-3">Mes Notes</a>
    <a href="exit.php" class="text-white">Déconnexion</a>
  </div>
</div>

<div class="container mt-5">
  <h1 class="mb-4">Mes Notes</h1>

  <form action="" method="post">  
    <div class="mb-3">
      <label for="module" class="form-label">Filter par module</label>
      <select class="form-select" id="module" name="module">
        <option value="" selected>--Tous les modules--</option>
        <?php
        try {
            $sql = 'SELECT id_module, nom_module FROM module ORDER BY nom_module';
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $modules = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if($modules) {
                foreach($modules as $m):
                    $selected = "";
                    if(isset($_POST['module']) && $_POST['module'] == $m["id_module"]) {
                        $selected = "selected";
                    }
        ?>
            <option value="<?= htmlspecialchars($m["id_module"]) ?>" <?= $selected ?>>
                <?= htmlspecialchars($m["nom_module"]) ?>
            </option>
        <?php 
                endforeach;
            }        
        } catch(PDOException $e) {
            echo '<div class="alert alert-danger">Erreur d\'exécution: ' . $e->getMessage() . '</div>';
        }
        ?>
      </select>
    </div>
    <button type="submit" class="btn btn-primary">Filtrer</button>
  </form>

<?php
if(isset($_POST['module']) && $_POST['module'] != "") {
    $m = htmlspecialchars(trim($_POST['module']));
    $sql = "SELECT m.nom_module, e.type_examen, e.date_examen, n.note 
            FROM module m 
            JOIN examen e ON m.id_module = e.id_module 
            JOIN notes n ON e.id_examen = n.id_examen 
            WHERE m.id_module = :im AND n.id_stg = :i 
            ORDER BY e.date_examen ASC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':im'=>$m, ':i'=>$id]);
    $moduler = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if ($moduler) {
        echo "<table class='table table-bordered text-center mt-4 table-striped'>";
        echo "<tr class='thead-dark'>
                <th>Module</th>
                <th>Type d'examen</th>
                <th>Date de l'examen</th>
                <th>Note</th>
              </tr>";
        foreach($moduler as $mr) {
            echo "<tr>
                    <td>" . htmlspecialchars($mr["nom_module"]) . "</td>
                    <td>" . htmlspecialchars($mr["type_examen"]) . "</td>
                    <td>" . htmlspecialchars($mr["date_examen"]) . "</td>
                    <td>" . htmlspecialchars($mr["note"]) . "</td>
                  </tr>";
        }   
        echo "</table>";
    } else {
        echo '<div class="alert alert-danger mt-3">Aucune note enregistrée pour ce module</div>';
    }
} else {
    $sql = "SELECT 
                m.nom_module AS module,
                e.type_examen,
                e.date_examen,
                n.note
            FROM notes n
            JOIN examen e ON n.id_examen = e.id_examen
            JOIN module m ON e.id_module = m.id_module
            WHERE n.id_stg = :i
            ORDER BY e.date_examen";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([":i"=>$id]);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($result) { 
        echo "<table class='table table-bordered text-center mt-4'>";
        echo "<tr>
                <th>Module</th>
                <th>Type d'examen</th>
                <th>Date de l'examen</th>
                <th>Note</th>
              </tr>";
        foreach($result as $r) {
            echo "<tr>
                    <td>" . htmlspecialchars($r["module"]) . "</td>
                    <td>" . htmlspecialchars($r["type_examen"]) . "</td>
                    <td>" . htmlspecialchars($r["date_examen"]) . "</td>
                    <td>" . htmlspecialchars($r["note"]) . "</td>
                  </tr>";
        }   
        echo "</table>";
    } else {
        echo '<div class="alert alert-danger mt-3">Aucune note enregistrée</div>';
    }
}
?>

</div>

<div class="header-footer d-flex justify-content-end px-4 mt-5">
  <a href="profil.php" class="text-white me-3">Profil</a>
  <a href="notes.php" class="text-white me-3">Mes Notes</a>
  <a href="exit.php" class="text-white">Déconnexion</a>
</div>

</body>
</html>