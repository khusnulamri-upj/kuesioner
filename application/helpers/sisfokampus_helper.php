<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

session_start();

if (!function_exists('sisfo_is_logged_in')) {

    function sisfo_is_logged_in() {
        if ((!empty($_SESSION['_Login'])) && (!empty($_SESSION['_LevelID']))) {
            return TRUE;
        }
        return FALSE;
    }
    
}

if (!function_exists('sisfo_get_user_data')) {

    function sisfo_get_user_data() {
        if ((!empty($_SESSION['_Login'])) && (!empty($_SESSION['_LevelID']))) {
            $sisfo_session = array(
                'sisfo_username' => $_SESSION['_Login'],
                'sisfo_level_id' => $_SESSION['_LevelID']
            );
            return $sisfo_session;
        }
        return FALSE;
    }
    
}

if (!function_exists('sisfo_get_username')) {

    function sisfo_get_username() {
        if ((!empty($_SESSION['_Login'])) && (!empty($_SESSION['_LevelID']))) {
            return $_SESSION['_Login'];
        }
        return FALSE;
    }
    
}

if (!function_exists('sisfo_get_level')) {

    function sisfo_get_level() {
        if ((!empty($_SESSION['_Login'])) && (!empty($_SESSION['_LevelID']))) {
            return $_SESSION['_LevelID'];
        }
        return FALSE;
    }
    
}

if (!function_exists('sisfo_is_dosen')) {

    function sisfo_is_dosen() {
        if ((!empty($_SESSION['_Login'])) && (!empty($_SESSION['_LevelID']))) {
            if ($_SESSION['_LevelID'] == '100') {
                return TRUE;
            }
        }
        return FALSE;
    }
    
}

if (!function_exists('sisfo_is_uts_or_uas')) {

    function sisfo_is_uts_or_uas() {
        $hostname = 'localhost';
        $username = 'root';
        $password = 'Upeje2013';
        $database = 'sisforn';
        
        $return = 'UTS';
        
        try {
            $db = new PDO('mysql:host='.$hostname.';dbname='.$database.'',
                    $username,
                    $password,
                    array( PDO::ATTR_EMULATE_PREPARES => false, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
            
            $sql_query = "SELECT MAX( t.TglUTSSelesai ) AS TglUTSSelesai, NOW( ) AS TglSekarang, IF( DATE_ADD( MAX( t.TglUTSSelesai ) , INTERVAL 1 DAY ) <= NOW( ) , 'UAS', 'UTS' ) AS periode
                FROM tahun t
                WHERE t.NA = 'N'";
            
            $stmt = $db->query($sql_query);
            $result = $stmt->fetch(PDO::FETCH_OBJ);
            
            $return = $result->periode;
        } catch (PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }

        return $return;
    }
    
}