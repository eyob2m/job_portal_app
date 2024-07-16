<?php

use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\Job\JobListController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test', function () {
    return response()->json([
        'message' => 'Api is working'
    ]);
});

Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);
Route::post('createjob', [JobListController::class, 'createjob']);
Route::get('getjobs', [JobListController::class, 'getjobs']);
