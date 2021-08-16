String rootUrl = 'https://kanaupi-notes.herokuapp.com';

Uri retrieveUrl = Uri.parse(rootUrl + '/notes/');
Uri createUrl = Uri.parse(rootUrl + '/notes/create/');
Uri deleteUrl(int id) {
  return Uri.parse(rootUrl + '/notes/' + id.toString() + '/delete/');
}

Uri updateUrl(int id) {
  return Uri.parse(rootUrl + '/notes/' + id.toString() + '/update/');
}
