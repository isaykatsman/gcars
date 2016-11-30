  static const GLenum conv_read_buffer_mode_table[] = {
    GL_FRONT_LEFT,
    GL_FRONT_RIGHT,
    GL_BACK_LEFT,
    GL_BACK_RIGHT,
    GL_FRONT,
    GL_BACK,
    GL_LEFT,
    GL_RIGHT,
    GL_AUX0,
    GL_AUX1,
    GL_AUX2,
    GL_AUX3,
  };
  read_buffer_mode = conv_read_buffer_mode_table[Int_val(_read_buffer_mode)];
#if defined(USE_MY_GL3_CORE_PROFILE)
  if (read_buffer_mode == 0x000A)
    caml_failwith("using gl-enum deprecated in core OpenGL 3");
#endif
