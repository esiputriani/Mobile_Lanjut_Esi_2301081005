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
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
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
            $stmt = $pdo->query("SELECT * FROM anggota");
            $students = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($students);
        }
        break;

        case 'POST':
            // Create new student
            $data = json_decode(file_get_contents("php://input"), true);
    
            if (!empty($data['kode_anggota']) && !empty($data['nama_anggota']) && !empty($data['jenis_kelamin']) && !empty($data['email'])) {
                $stmt = $pdo->prepare("INSERT INTO anggota (kode_anggota, nama_anggota,jenis_kelamin, email) VALUES (?, ?, ? , ?)");
                $stmt->execute([$data['kode_anggota'], $data['nama_anggota'], $data['jenis_kelamin'], $data['email']]);
                echo json_encode(["message" => "Anggotacreated", "id" => $pdo->lastInsertId()]);
            } else {
                http_response_code(400);
                echo json_encode(["message" => "Invalid data"]);
            }
            break;
            case 'PUT':
                // Update student by ID
                if ($id) {
                    $data = json_decode(file_get_contents("php://input"), true);
        
                    $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
                    $stmt->execute([$id]);
                    $student = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($student) {
                        $kode_anggota = $data['kode_anggota'] ?? $student['kode_anggota'];
                        $nama_anggota = $data['nama_anggota'] ?? $student['nama_anggota'];
                        $jenis_kelamin = $data['jenis_kelamin'] ?? $student['jenis_kelamin'];
                        $email = $data['email'] ?? $student['email'];
                        
        
                        $stmt = $pdo->prepare("UPDATE students SET kode_anggota = ?, nama_anggota = ?, jenis_kelamin = ?, email = ? WHERE id = ?");
                        $stmt->execute([$kode_anggota, $age, $major, $id]);
                        echo json_encode(["message" => "Student updated"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "Student not found"]);
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(["message" => "ID not provided"]);
                }
                break;
        
            case 'DELETE':
                // Delete student by ID
                if ($id) {
                    $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
                    $stmt->execute([$id]);
                    $student = $stmt->fetch(PDO::FETCH_ASSOC);
        
                    if ($student) {
                        $stmt = $pdo->prepare("DELETE FROM anggota WHERE id = ?");
                        $stmt->execute([$id]);
                        echo json_encode(["message" => "Student deleted"]);
                    } else {
                        http_response_code(404);
                        echo json_encode(["message" => "Student not found"]);
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