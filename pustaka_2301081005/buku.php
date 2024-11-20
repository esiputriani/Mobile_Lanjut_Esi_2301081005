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
            // Get student by ID
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $student = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($student) {
                echo json_encode($student);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Student not found"]);
            }
        } else {
            // Get all students
            $stmt = $pdo->query("SELECT * FROM buku");
            $students = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($students);
        }
        break;

        case 'POST':
            // Create new student
            $data = json_decode(file_get_contents("php://input"), true);
    
            if (!empty($data['kodebuku']) && !empty($data['judulbuku']) && !empty($data['pengarang']) && !empty($data['penerbit']) && !empty($data['tahunterbit'])) {
                $stmt = $pdo->prepare("INSERT INTO buku (kodebuku, judulbuku,pengarang, penerbit, tahunterbit) VALUES (?, ?, ? , ? ,?)");
                $stmt->execute([$data['kodebuku'], $data['judulbuku'], $data['pengarang'], $data['penerbit'] ,$data['tahunterbit']]);
                echo json_encode(["message" => "bukucreated", "id" => $pdo->lastInsertId()]);
            } else {
                http_response_code(400);
                echo json_encode(["message" => "Invalid data"]);
            }
            break;
            case 'PUT':
                // Update student by ID
                if ($id) {
                    $data = json_decode(file_get_contents("php://input"), true);
        
                    $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
                    $stmt->execute([$id]);
                    $student = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($student) {
                        $kode_buku = $data['kodebuku'] ?? $student['kodebuku'];
                        $judul_buku = $data['judulbuku'] ?? $student['judulbuku'];
                        $pengarang = $data['pengarang'] ?? $student['pengarang'];
                        $penerbit = $data['penerbit'] ?? $student['penerbit'];
                        $tahun_terbit = $data['tahunterbit'] ?? $student['tahunterbit'];
                        
        
                        $stmt = $pdo->prepare("UPDATE students SET kodebuku = ?, judulbuku = ?, pengarang = ?, penerbit = ? ,tahun terbit = ? WHERE id = ?");
                        $stmt->execute([$kode_buku, $age, $major, $id]);
                        echo json_encode(["message" => "Buku updated"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "Buku not found"]);
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(["message" => "ID not provided"]);
                }
                break;
        
            case 'DELETE':
                // Delete student by ID
                if ($id) {
                    $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
                    $stmt->execute([$id]);
                    $student = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($student) {
                        $stmt = $pdo->prepare("DELETE FROM buku WHERE id = ?");
                        $stmt->execute([$id]);
                        echo json_encode(["message" => "Buku deleted"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "Buku not found"]);
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
