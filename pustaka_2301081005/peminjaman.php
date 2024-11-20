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
            // Get peminjaman by ID
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                echo json_encode($peminjaman);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "peminjaman not found"]);
            }
        } else {
            // Get all peminjamans
            $stmt = $pdo->query("SELECT * FROM peminjaman");
            $peminjamans = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($peminjamans);
        }
        break;

        case 'POST':
            // Create new peminjaman
            $data = json_decode(file_get_contents("php://input"), true);
    
            if (!empty($data['nama']) && !empty($data['kodeanggota']) && !empty($data['tpinjam']) && !empty($data['tkembali']) && !empty($data['kodebuku'])) {
                $stmt = $pdo->prepare("INSERT INTO peminjaman (nama, kodeanggota,tpinjam, tkembali, kodebuku) VALUES (?, ?, ? , ? ,?)");
                $stmt->execute([$data['nama'], $data['kodeanggota'], $data['tpinjam'], $data['tkembali'] ,$data['kodebuku']]);
                echo json_encode(["message" => "peminjamancreated", "id" => $pdo->lastInsertId()]);
            } else {
                http_response_code(400);
                echo json_encode(["message" => "Invalid data"]);
            }
            break;
            case 'PUT':
                // Update peminjaman by ID
                if ($id) {
                    $data = json_decode(file_get_contents("php://input"), true);
        
                    $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
                    $stmt->execute([$id]);
                    $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($peminjaman) {
                        $nama = $data['nama'] ?? $peminjaman['nama'];
                        $kode_anggota = $data['kodeanggota'] ?? $peminjaman['kodeanggota'];
                        $tpinjam = $data['tpinjam'] ?? $peminjaman['tpinjam'];
                        $tkembali = $data['tkembali'] ?? $peminjaman['tkembali'];
                        $kodebuku = $data['kodebuku'] ?? $peminjaman['kodebuku'];
                        
        
                        $stmt = $pdo->prepare("UPDATE peminjamans SET nama = ?, kodeanggota = ?, tpinjam = ?, tkembali = ? ,kodebuku = ? WHERE id = ?");
                        $stmt->execute([$nama, $age, $major, $id]);
                        echo json_encode(["message" => "peminjaman updated"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "peminjaman not found"]);
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(["message" => "ID not provided"]);
                }
                break;
        
            case 'DELETE':
                // Delete peminjaman by ID
                if ($id) {
                    $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
                    $stmt->execute([$id]);
                    $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($peminjaman) {
                        $stmt = $pdo->prepare("DELETE FROM peminjaman WHERE id = ?");
                        $stmt->execute([$id]);
                        echo json_encode(["message" => "peminjaman deleted"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "peminjaman not found"]);
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
