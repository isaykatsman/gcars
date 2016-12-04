  static const GLenum conv_get_float_1_table[] = {
    GL_CURRENT_RASTER_DISTANCE,
    GL_FOG_DENSITY,
    GL_FOG_END,
    GL_FOG_INDEX,
    GL_FOG_START,
    GL_INDEX_CLEAR_VALUE,
    GL_LINE_WIDTH,
    GL_LINE_WIDTH_GRANULARITY,
    GL_POINT_SIZE,
    GL_STENCIL_CLEAR_VALUE,
    GL_DEPTH_CLEAR_VALUE,
    GL_SAMPLE_COVERAGE_VALUE,
    GL_ZOOM_X,
    GL_ZOOM_Y,
    GL_ALPHA_SCALE,
    GL_BLUE_SCALE,
    GL_DEPTH_SCALE,
    GL_GREEN_SCALE,
    GL_RED_SCALE,
    GL_POINT_SIZE_GRANULARITY,
    GL_POINT_SIZE_MAX,
    GL_POINT_SIZE_MIN,
    GL_POINT_FADE_THRESHOLD_SIZE,
    GL_CURRENT_INDEX,
    GL_POLYGON_OFFSET_FACTOR,
    GL_POLYGON_OFFSET_UNITS,
  };
  get_float_1 = conv_get_float_1_table[Int_val(_get_float_1)];
#if defined(USE_MY_GL3_CORE_PROFILE)
  if (get_float_1 == 0x000A)
    caml_failwith("using gl-enum deprecated in core OpenGL 3");
#endif
