$(function() {
  lel = {
    source: "/autocomplete/",
    ajaxSettings: {
      dataType: "json"
    },
    noCache: true,
    deferRequestBy: 2,
    onSelect: function(t) {
      f(t.value, t.data[0], t.data[1])
    },
    transformResult: function(t) {
      return {
        suggestions: $.map(t.results, function(u) {
          return {
            value: u.name,
            data: u.coordinates
          }
        })
      }
    }
  };

  $("#id_trip_from").autocomplete(lel);
  $("#id_trip_to").autocomplete(lel);

});
