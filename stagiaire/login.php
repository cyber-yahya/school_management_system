<?php
session_start();

// Déplacer tout le traitement PHP avant le HTML
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(isset($_POST["login"], $_POST["password"])) {
        $login = htmlspecialchars(trim($_POST["login"]));
        $mdp = htmlspecialchars(trim($_POST["password"]));
        $err = [];

        if(empty($login)) {
            $err[] = "Login requis!";
        }
        if(empty($mdp)) {
            $err[] = "Mot de passe requis!";
        }
        
        if(!empty($err)) {
            $error_message = "<div class='alert alert-danger'><ul>";
            foreach($err as $e) {
                $error_message .= "<li>".$e."</li>";
            }
            $error_message .= "</ul></div>";
        } else {
            require "../connexion.php";

            try {
                $sql = "SELECT * FROM stagiaire WHERE login_stg = :l AND mot_de_passe_stg = :m";
                $stmt = $pdo->prepare($sql);
                $stmt->execute([":l"=>$login,":m"=>$mdp]);
                $result = $stmt->fetch(PDO::FETCH_ASSOC);

                if($result) {
                    $_SESSION['stagiaire'] = $result;
                    header("location:dashboard.php");
                    exit();
                } else {
                    $error_message = "<div class='alert alert-danger'>Login ou mot de passe incorrect</div>";
                }
            } catch(PDOException $e) {
                $error_message = "<div class='alert alert-danger'>Erreur de connexion à la base de données</div>";
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Connexion Stagiaire</title>
  <link href="../bootstrap/bootstrap.css" rel="stylesheet">
  <link href="../bootstrap/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
  <div class="card shadow p-4" style="min-width: 350px;">
    <h4 class="text-center text-primary mb-4">Connexion Stagiaire</h4>
    
    <?php
    // Afficher les messages d'erreur après le titre
    if(isset($error_message)) {
        echo $error_message;
    }
    ?>
    
    <form action="" method="POST">
      <div class="mb-3">
        <label for="login" class="form-label">Login</label>
        <input type="text" name="login" id="login" class="form-control" required>
      </div>
      <div class="mb-3">
        <label for="mot_de_passe" class="form-label">Mot de passe</label>
        <input type="password" name="password" id="mdp" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100 mb-2">Se connecter</button>
      <a class="btn btn-danger w-100" href="../index.php">Return</a>
    </form>
  </div>
</body>
</html>