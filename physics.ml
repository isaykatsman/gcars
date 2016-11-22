type car_model = {
  chassis : cp_body ref;
  wheel1 : cp_body ref;
  wheel2 : cp_body ref; 
}

type world = ref {
  cars : car_model list;
  terrain : float list;
  space : cp_space ref;
  num_steps : int;
}
