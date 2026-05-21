<?php
// 1. Requerimos el archivo de la base de datos que está en el Core
require_once '../App/Core/Database.php';

// 2. Instanciamos la clase
$db = new Database();

// 3. Intentamos obtener la conexión
$conexion = $db->getConnection();

// 4. Comprobamos si funcionó
if($conexion) {
    echo "<h1>¡Éxito! 🚀</h1>";
    echo "<p>PHP se conectó perfectamente a la base de datos <b>final_desarrollo_web</b>.</p>";
} else {
    echo "<h1>Algo falló 🚨</h1>";
}