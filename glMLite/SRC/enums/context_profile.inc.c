  static const GLenum conv_context_profile_table[] = {
    GLUT_CORE_PROFILE,
    GLUT_COMPATIBILITY_PROFILE,
  };
  context_profile = conv_context_profile_table[Int_val(_context_profile)];
#if defined(USE_MY_GL3_CORE_PROFILE)
  if (context_profile == 0x000A)
    caml_failwith("using gl-enum deprecated in core OpenGL 3");
#endif
