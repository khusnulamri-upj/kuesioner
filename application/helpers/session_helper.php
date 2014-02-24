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