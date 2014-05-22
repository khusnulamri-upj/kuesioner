<!DOCTYPE html>
<html lang="id">
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
            .width-set3 {
                width: 95%;
            }
            .width-set4 {
                width: 100%;
            }
            .titleshrink1 {
                font-size: 125%;
            }
            .s1 {
                font-size: 75%;
            }
            .s2 {
                display: none;
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
            .width-set3 {
                width: 97%;
            }
            .width-set4 {
                width: 100%;
            }
            .titleshrink1 {
                font-size: 150%;
            }
            .s1 {
                font-size: 100%;
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
            .width-set3 {
                width: 99%;
            }
            .width-set4 {
                width: 700px;
            }
            .titleshrink1 {
                font-size: 150%;
            }
            .s1 {
                font-size: 100%;
            }
        }
        @media print {    
            .no-print, .no-print *
            {
                display: none !important;
            }
            .np-select-border, .np-select-border *
            {
                background-color:white;
                color:black;
                border:0 !important;
                -webkit-appearance:none;
                text-indent:0.01px;
                text-overflow:'';
                -moz-appearance:none;
            }
            .titleshrink1 {
                font-size: 150%;
            }
            .p-padding {
                page-break-after: always;
            }
        }
        .width-set2 {
            min-width: 19px;
            text-align: right;
        }
        .boxed {
            display: inline-block;
            text-align: center;
        }
        .centered {
            padding:.3em .3em .3em .3em;
            text-align: center;
        }
        .button {
            outline:none;
            cursor:pointer;
            text-decoration:none;
            font:14px/100% Arial,Helvetica,sans-serif;
            line-height:120%;
            padding:.25em 2em .3em;
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
        .disabled-button {
            outline:none;
            cursor:not-allowed;
            text-decoration:none;
            font:14px/100% Arial,Helvetica,sans-serif;
            line-height:120%;
            padding:.25em 2em .3em;
            text-shadow:0 1px 1px rgba(0,0,0,.3);
            -webkit-box-shadow:0 1px 2px rgba(0,0,0,.2);
            -moz-box-shadow:1px 1px 4px #AAAAAA;
            box-shadow:0 1px 2px rgba(0,0,0,.2);
            color:#DDDDDD;
            border:2px solid white !important;
            background:#E0E0E0;
            background:-webkit-gradient(linear,left top,left bottom,from(#D8D8D8),to(#808080));
            background:-moz-linear-gradient(top,#D8D8D8,#808080);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#D8D8D8',endColorstr='#808080');
        }
        .bordered tr td {
            border:1px solid gray;
            padding:.2em .4em .2em .3em;
        }
        .yes-top-border td {
            border-top:3px solid gray !important;
        }
        .yes-bottom-border td {
            border-bottom:3px solid gray !important;
        }
        .no-right-border {
            border-right-color: white !important;
        }
        .no-bottom-border {
            border-bottom-color: white !important;
        }
        </style>
    </head>
    <body>