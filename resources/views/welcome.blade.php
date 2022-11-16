@extends('layouts.app')

@section('content')
  <div class="card">
    <div class="card-header h4">
      Arquivo README.md
    </div>
    <div class="card-body">
      {!! md2html(file_get_contents(base_path('README.md'))) !!}
    </div>
  </div>

  <div class="card">
    <div class="card-header h4">
      Conteúdo do laravel-usp-theme (@@parent)
    </div>
    <div class="card-body">
      @parent
    </div>
  </div>
@endsection
