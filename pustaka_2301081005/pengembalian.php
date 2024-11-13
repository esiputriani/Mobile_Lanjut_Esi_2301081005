<?php
require 'config.php';

// Set headers to allow API access from outside
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$method = $_SERVER['REQUEST_METHOD'];
$path_info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : (isset($_SERVER['ORIG_PATH_INFO']) ? $_SERVER['ORIG_PATH_INFO'] : '');
$request = explode('/', trim($path_info, '/'));
$id = isset($request[1]) ? (int)$request[1] : null;

switch ($method) {
    case 'GET':
        if ($id) {
            // Get pengembalian by ID
            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($pengembalian) {
                echo json_encode($pengembalian);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "pengembalian not found"]);
            }
        } else {
            // Get all pengembalians
            $stmt = $pdo->query("SELECT * FROM pengembalian");
            $pengembalians = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($pengembalians);
        }
        break;

        case 'POST':
            // Create new pengembalian
            $data = json_decode(file_get_contents("php://input"), true);
    
            if ( !empty($data['kode_anggota']) && !empty($data['tkembali']) && !empty($data['denda']) && !empty($data['kodebuku'])) {
                $stmt = $pdo->prepare("INSERT INTO pengembalian (kode_anggota,tkembali,denda, kodebuku) VALUES (?, ?, ? , ? ,?)");
                $stmt->execute([ $data['kode_anggota'], $data['tkembali'], $data['denda'] ,$data['kodebuku']]);
                echo json_encode(["message" => "pengembaliancreated", "id" => $pdo->lastInsertId()]);
            } else {
                http_response_code(400);
                echo json_encode(["message" => "Invalid data"]);
            }
            break;
            case 'PUT':
                // Update pengembalian by ID
                if ($id) {
                    $data = json_decode(file_get_contents("php://input"), true);
        
                    $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
                    $stmt->execute([$id]);
                    $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($pengembalian) {
                        
                        $kode_anggota = $data['kode_anggota'] ?? $pengembalian['kode_anggota'];
     
                        $tkembali = $data['tkembali'] ?? $pengembalian['tkembali'];
                        $denda = $data['denda'] ?? $pengembalian['denda'];
                        $kodebuku = $data['kodebuku'] ?? $pengembalian['kodebuku'];
                        
        
                        $stmt = $pdo->prepare("UPDATE pengembalians SET kode_anggota = ?, tkembali = ?, denda = ? ,kodebuku = ? WHERE id = ?");
                        $stmt->execute([$nama, $age, $major, $id]);
                        echo json_encode(["message" => "pengembalian updated"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "pengembalian not found"]);
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(["message" => "ID not provided"]);
                }
                break;
        
            case 'DELETE':
                // Delete pengembalian by ID
                if ($id) {
                    $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
                    $stmt->execute([$id]);
                    $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($pengembalian) {
                        $stmt = $pdo->prepare("DELETE FROM pengembalian WHERE id = ?");
                        $stmt->execute([$id]);
                        echo json_encode(["message" => "pengembalian deleted"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "pengembalian not found"]);
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(["message" => "ID not provided"]);
                }
                break;
        
            default:
                http_response_code(405);
                echo json_encode(["message" => "Method not allowed"]);
                break;
        }
        ?>