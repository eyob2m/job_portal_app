<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Request\LoginRequest;
use App\Http\Requests\Request\RegisterRequest;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthenticationController extends Controller
{
    public function register(RegisterRequest $request)
    {
        try {
            $validatedData = $request->validated();
            $user = User::create([
                "name" => $validatedData["name"],
                "username" => $validatedData["username"],
                "email" => $validatedData["email"],
                "password" => Hash::make($validatedData["password"])
            ]);

            $token = $user->createToken("job_portal")->plainTextToken;
            return response()->json([
                "user" => $user->name,
                "token" => $token
            ], 201);
        } catch (ValidationException $e) {
            return response()->json([
                "message" => "Validation Failed",
                "errors" => $e->errors()
            ], 422);
        }
    }

    public function login(LoginRequest $request)
    {
        $validatedData = $request->validated();
        $user = User::whereusername($request->username)->first();
        if (!$user || !Hash::check($request->password, $user->password)) {
            return  response()->json([
                "message" => "Invalid Credentials"
            ], 401);
        }

        $token = $user->createToken("job_portal")->plainTextToken;
        return response()->json([
            "message" => "Welcome " . $user->name,
            "token" => $token
        ], 200);
    }
}
