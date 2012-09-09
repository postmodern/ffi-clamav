require 'ffi/clamav/types'

require 'ffi'

module FFI
  module ClamAV
    extend FFI::Library

    ffi_lib ['clamav', 'libclamav.so.6']

    attach_function :cl_init, [:uint], :int

    attach_function :cl_engine_new, [], :pointer
    attach_function :cl_engine_set_num, [:pointer, :cl_engine_field, :long_long], :int
    attach_function :cl_engine_get_num, [:pointer, :cl_engine_field, :pointer], :long_long
    attach_function :cl_engine_set_str, [:pointer, :cl_engine_field, :string], :int
    attach_function :cl_engine_get_str, [:pointer, :cl_engine_field, :pointer], :string
    attach_function :cl_engine_settings_copy, [:pointer], :pointer
    attach_function :cl_engine_settings_apply, [:pointer, :pointer], :int
    attach_function :cl_engine_settings_free, [:pointer], :int
    attach_function :cl_engine_compile, [:pointer], :int
    attach_function :cl_engine_addref, [:pointer], :int
    attach_function :cl_engine_free, [:pointer], :int

    attach_function :cl_engine_set_clcb_pre_scan, [:pointer, :clcb_pre_scan], :void
    attach_function :cl_engine_set_clcb_post_scan, [:pointer, :clcb_post_scan], :void
    attach_function :cl_engine_set_clcb_sigload, [:pointer, :clcb_sigload, :pointer], :void

    attach_function :cl_set_clcb_msg, [:clcb_msg], :void

    attach_function :cl_engine_set_clcb_hash, [:pointer, :clcb_hash], :void

    # file scanning
    attach_function :cl_scandesc, [:int, :pointer, :pointer, :pointer, :uint], :int
    attach_function :cl_scandesc_callback, [:int, :pointer, :pointer, :pointer, :uint, :pointer], :int

    attach_function :cl_scanfile, [:string, :pointer, :pointer, :pointer, :uint], :int
    attach_function :cl_scanfile_callback, [:string, :pointer, :pointer, :pointer, :uint, :pointer], :int

    # database handling
    attach_function :cl_load, [:string, :pointer, :pointer, :uint], :int
    attach_function :cl_retdbdir, [], :string

    #
    # engine handling
    #

    # CVD
    attach_function :cl_cvdhead, [:string], :pointer
    attach_function :cl_cvdparse, [:string], :pointer
    attach_function :cl_cvdverify, [:string], :int
    attach_function :cl_cvdfree, [:pointer], :void

    # db dir stat functions
    attach_function :cl_statinidir, [:string, :pointer], :int
    attach_function :cl_statchkdir, [:pointer], :int
    attach_function :cl_statfree, [:pointer], :int
    
    # count signatures
    attach_function :cl_countsigs, [:string, :uint, :pointer], :int

    # enable debug messages
    attach_function :cl_debug, [], :void

    # software versions
    attach_function :cl_retflevel, [], :uint
    attach_function :cl_retver, [], :string

    # others
    attach_function :cl_strerror, [:int], :string

  end
end
