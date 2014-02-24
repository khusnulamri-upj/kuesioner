<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

if (!function_exists('url_safe_encode')) {

    function url_safe_encode($url) {
        return strtr($url,array(
            '+' => '.',
            '=' => '-',
            '/' => '~')
        );
    }

}

if (!function_exists('url_safe_decode')) {

    function url_safe_decode($url) {
        return strtr($url,array(
            '.' => '+',
            '-' => '=',
            '~' => '/')
        );
    }
    
}