  static const GLenum conv_shader_type_table[] = {
    GL_VERTEX_SHADER,
    GL_FRAGMENT_SHADER,
    GL_GEOMETRY_SHADER,
  };
  shader_type = conv_shader_type_table[Int_val(_shader_type)];
#if defined(USE_MY_GL3_CORE_PROFILE)
  if (shader_type == 0x000A)
    caml_failwith("using gl-enum deprecated in core OpenGL 3");
#endif
