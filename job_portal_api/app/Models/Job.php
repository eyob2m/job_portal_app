<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;

class Job extends Model
{
    use HasFactory;
    use HasApiTokens;

    protected $table = "job_lists";

    protected $fillable = ["title", "company_name", "company_logo", "description", "location", "salary", "start_date", "end_date"];
}
