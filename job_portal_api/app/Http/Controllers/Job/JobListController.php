<?php

namespace App\Http\Controllers\Job;

use App\Http\Controllers\Controller;
use App\Http\Requests\JobList;
use App\Models\Job;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class JobListController extends Controller
{
    public function createjob(Request $request)
    {
        $request->validate([
            'title' => 'required|string',
            'company_name' => 'required|string',
            'company_logo' => 'required|image|mimes:jpeg,png,jpg,svg|max:2048',
            'description' => 'required|string',
            'location' => 'required|string',
            'salary' => 'required|numeric',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
        ]);

        if ($request->hasFile('company_logo')) {
            $logo = $request->file('company_logo');
            $logoName = time() . '.' . $logo->getClientOriginalExtension();
            $path = $logo->storeAs('logos', $logoName, 'public');

            $job = Job::create([
                'title' => $request->title,
                'company_name' => $request->company_name,
                'company_logo' => $path,
                'description' => $request->description,
                'location' => $request->location,
                'salary' => $request->salary,
                'start_date' => $request->start_date,
                'end_date' => $request->end_date,
            ]);

            $token = $job->createToken("job_portal")->plainTextToken;

            return response()->json([
                'company_name' => $job->company_name,
                'company_logo' => $job->company_logo,
                'job_title' => $job->title,
                'description' => $job->description,
                'location' => $job->location,
                'salary' => $job->salary,
                'start_date' => $job->start_date,
                'end_date' => $job->end_date,
                'token' => $token
            ], 201);
        }

        return response()->json([
            'message' => 'Logo upload failed'
        ], 500);
    }

    public function getjobs(Request $request)
    {
        $jobs = Job::all();
        if ($jobs->isEmpty()) {
            return response()->json([
                'message' => 'No jobs found',
            ], 404);
        }
        return response()->json([
            'jobs' => $jobs,
        ], 200);
    }
}
