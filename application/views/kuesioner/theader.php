<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="<?php echo base_url('assets/ico'); ?>/1393245769_93207.ico">
        <title>Kuesioner</title>
        <style>
        @media only screen
        and (max-width : 480px) {
            .width-set1 {
                width: 82%;
                display: inline-block;
            }
            table {
                margin: 0 auto 0 3%;
                width: 82%;
                border-collapse:collapse;
            }
        }
        @media only screen
        and (min-width : 480px)
        and (max-width : 768px) {
            .width-set1 {
                width: 91%;
                display: inline-block;
            }
            table {
                margin: 0 auto 0 6%;
                width: 91%;
                border-collapse:collapse;
            }
        }
        @media only screen
        and (min-width : 769px) {
            .width-set1 {
                width: 700px;
                display: inline-block;
            }
            table {
                margin: 0 auto;
                border-collapse:collapse;
            }
        }    
        .button {
            outline:none;
            cursor:pointer;
            text-decoration:none;
            font:14px/100% Arial,Helvetica,sans-serif;
            line-height:120%;
            padding:.45em 2em .5em;
            text-shadow:0 1px 1px rgba(0,0,0,.3);
            -webkit-box-shadow:0 1px 2px rgba(0,0,0,.2);
            -moz-box-shadow:1px 1px 4px #AAAAAA;
            box-shadow:0 1px 2px rgba(0,0,0,.2);
            color:#E9F3FE;
            border:2px solid white !important;
            background:#1D87F7;
            background:-webkit-gradient(linear,left top,left bottom,from(#16AFFA),to(#209AF4));
            background:-moz-linear-gradient(top,#16AFFA,#209AF4);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#16AFFA',endColorstr='#209AF4');
        }
        .button:hover {
            text-decoration:none;
            background:#f47c20;
            background:-webkit-gradient(linear,left top,left bottom,from(#f88e11),to(#f06015));
            background:-moz-linear-gradient(top,#f88e11,#f06015);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f88e11',endColorstr='#f06015');
        }
        .bordered td {
            border:1px solid gray;
            padding:.2em .2em .2em .2em;
        }
        .no-bottom-border {
            border-bottom-color: white !important;
        }
        .no-right-border {
            border-right-color: white !important;
        }
        </style>
    </head>
    <body>