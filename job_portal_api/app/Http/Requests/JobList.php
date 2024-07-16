<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JobList extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            "title" => "string|required",
            "company_name" => "string|required",
            "company_logo' => 'required|image|mimes:jpeg,png,jpg,svg|max:2048",
            "description" => "string|required",
            "location" => "string|required",
            "salary" => "numeric|required",
            "start_date" => "date|required",
            "end_date" => "date|required"
        ];
    }
}
