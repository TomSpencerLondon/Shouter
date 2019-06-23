import 'jquery-ui-dist/jquery-ui';

$('#search-form-input').autocomplete({
    source: "search/autocomplete",
    minLength: 2
  });
