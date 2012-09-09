#
# ffi-clamav - Ruby FFI bindings for libclamav
#
# Copyright (c) 2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ffi'

module FFI
  module ClamAV
    extend FFI::Library

    enum :cl_error_t, [
      # libclamav specific
      :clean, 0,
      :success, 0,
      :virus,
      :enullarg,
      :earg,
      :emalfdb,
      :ecvd,
      :everify,
      :eunpack,

      # I/O and memory errors
      :eopen,
      :ecreat,
      :eunlink,
      :estat,
      :eread,
      :eseek,
      :ewrite,
      :edup,
      :eacces,
      :etmpfile,
      :etmpdir,
      :emap,
      :emem,
      :etimeout,

      # internal (not reported outside libclamav)
      :break,
      :emaxrec,
      :emaxsize,
      :emaxfiles,
      :eformat,
      :ebytecode, # may be reported in testmode
      :ebytecode_testfail, # may be reported in testmode

      # c4w error codes
      :elock,
      :ebusy,
      :estate,

      # no error codes below this line please
      :elast_error
    ]

    DB_OPTIONS = {
      :phishing          => 0x2,
      :phishing_urls     => 0x8,
      :pua               => 0x10,
      :cvdnotmp	         => 0x20,    # obsolete
      :official	         => 0x40,    # internal
      :pua_mode	         => 0x80,
      :pua_include       => 0x100,
      :pua_exclude       => 0x200,
      :compiled	         => 0x400,   # internal
      :directory	       => 0x800,   # internal
      :official_only     => 0x1000,
      :bytecode          => 0x2000,
      :signed            => 0x4000,  # internal
      :bytecode_unsigned => 0x8000
    }

    # recommended db settings
    DB_STDOPT = [:phishing, :phishing_urls, :bytecode]

    # scan options
    SCAN_OPTIONS = {
      :raw                     => 0x0,
      :archive                 => 0x1,
      :mail                    => 0x2,
      :ole2                    => 0x4,
      :blockencrypted          => 0x8,
      :html                    => 0x10,
      :pe                      => 0x20,
      :blockbroken             => 0x40,
      :mailurl                 => 0x80,  # ignored
      :blockmax                => 0x100, # ignored
      :algorithmic             => 0x200,
      :phishing_blockssl       => 0x800, # ssl mismatches, not ssl by itself
      :phishing_blockcloak     => 0x1000,
      :elf                     => 0x2000,
      :pdf                     => 0x4000,
      :structured              => 0x8000,
      :structured_ssn_normal   => 0x10000,
      :structured_ssn_stripped => 0x20000,
      :partial_message         => 0x40000,
      :heuristic_precedence    => 0x80000,
      :blockmacros             => 0x100000
    }

    # recommended scan settings
    SCAN_STDOPT = [:archive, :mail, :ole2, :pdf, :html, :pe, :algorithmic, :elf]

    # countsigs options
    COUNTSIGS_OPTIONS = {
      :official   => 0x1,
      :unofficial => 0x2,
      :all        => (0x2 | 0x1)
    }

    enum :cl_engine_field, [
      :max_scansize,	    # uint64_t
      :max_filesize,	    # uint64_t
      :max_recursion,	    # uint32_t
      :max_files,	        # uint32_t
      :min_cc_count,	    # uint32_t
      :min_ssn_count,	    # uint32_t
      :pua_categories,	  # (char *)
      :db_options,	      # uint32_t
      :db_version,	      # uint32_t
      :db_time,		        # time_t
      :ac_only,		        # uint32_t
      :ac_mindepth,	      # uint32_t
      :ac_maxdepth,	      # uint32_t
      :tmpdir,		        # (char *)
      :keeptmp,		        # uint32_t
      :bytecode_security, # uint32_t
      :bytecode_timeout,  # uint32_t
      :bytecode_mode      # uint32_t
    ]

    enum :cl_bytecode_security, [
      :trust_all, 0,
      :trust_signed,
      :trust_nothing
    ]

    enum :cl_bytecode_mode, [
      :auto, 0,     # JIT if possible, fallback to interpreter
      :jit,         # force JIT
      :interpreter, # force interpreter
      :test,        # both JIT and interpreter, compare results,
                    # all failures are fatal
      :off          # for query only, not settable
    ]

    callback :clcb_pre_scan, [:int, :pointer], :cl_error_t

    callback :clcb_post_scan, [:int, :int, :string, :pointer], :cl_error_t

    callback :clcb_sigload, [:string, :string, :pointer], :int

    enum :cl_msg, [
      # leave room for more message levels in the future
      :info_verbose, 32, # verbose
      :warn,         64, # LibClamAV WARNING:
      :error,        128 # LibClamAV ERROR:
    ]

    callback :clcb_msg, [:cl_msg, :string, :string, :pointer], :void
    
    callback :clcb_hash, [:int, :ulong_long, :string, :string, :pointer], :void

  end
end
