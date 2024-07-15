<?php

namespace App\Http\Controllers\Job;

use App\Http\Controllers\Controller;
use App\Http\Requests\JobList;
use App\Models\Job;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\Request;


class JobListController extends Controller
{
    public function createjob(JobList $request)
    {
        try {
            $validatedData = $request->validated();
            $job = Job::create([
                "title" => $validatedData["title"],
                "company_name" => $validatedData["company_name"],
                "description" => $validatedData["description"],
                "location" => $validatedData["location"],
                "salary" => $validatedData["salary"],
                "start_date" => $validatedData["start_date"],
                "end_date" => $validatedData["end_date"],
            ]);

            $token = $job->createToken("job_portal")->plainTextToken;
            return response()->json([
                "company name" => $job->company_name,
                "job title" => $job->title,
                "description" => $job->description,
                "location" => $job->location,
                "salary" => $job->salary,
                "start_date" => $job->start_date,
                "end_date" => $job->end_date,
                "token" => $token

            ], 201);
        } catch (ValidationException $e) {
            return response()->json([
                "message" => "Validation error",
                "errors" => $e->errors(),

            ], 422);
        }
    }
    public function getjobs(Request $request)
    {
        $jobs = Job::all();
        if ($jobs->isEmpty()) {
            return response()->json([
                "message" => "No jobs found",
            ], 404);
        }
        return response()->json([
            "jobs" => $jobs,
        ], 200);
    }
}
