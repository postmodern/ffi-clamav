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

require 'ffi/clamav/library'
require 'ffi/clamav/settings'
require 'ffi/clamav/error'

require 'time'

module FFI
  module ClamAV
    class Engine < FFI::AutoPointer

      def initialize(ptr=ClamAV.cl_engine_new)
        super(ptr)
      end

      def self.release(ptr)
        ClamAV.cl_engine_free(ptr)
      end

      def settings
        Settings.new(ClamAV.cl_engine_settings_copy(self))
      end

      def settings=(other_settings)
        ClamAV.cl_engine_settings_apply(other_settings)
      end

      def max_scansize
        get_field :max_scansize, :number
      end

      def max_scansize=(new_max_scansize)
        set_field :max_scansize, :number, new_max_scansize
      end

      def max_filesize
        get_field :max_filesize, :number
      end

      def max_filesize=(new_max_filesize)
        set_field :max_filesize, :number, new_max_filesize
      end

      def max_recursion(new_max_recursion)
        get_field :max_recursion, :number
      end

      def max_recursion=(new_max_recursion)
        set_field :max_recursion, :number, new_max_recursion
      end

      def max_files
        get_field :max_files, :number
      end

      def max_files=(new_max_files)
        set_field :max_files, :number, new_max_files
      end

      def min_cc_count
        get_field :min_cc_count, :number
      end

      def min_cc_count=(new_min_cc_count)
        set_field :min_cc_count, :number, new_min_cc_count
      end

      def min_ssn_count
        get_field :min_ssn_count, :number
      end

      def min_ssn_count=(new_min_ssn_count)
        set_field :min_ssn_count, :number, new_min_ssn_count
      end

      def pua_categories
        get_field :pua_categories, :string
      end

      def pua_categories=(new_pua_categories)
        set_field :pua_categories, :string, new_pua_categories
      end

      def db_options
        get_field :db_options, :number
      end

      def db_options=(new_db_options)
        set_field :db_options, :number, new_db_options
      end

      def db_version
        get_field :db_version, :number
      end

      def db_version=(new_db_version)
        set_field :db_version, :number, new_db_version
      end

      def db_time
        Time.at(get_field(:db_time,:number))
      end
      
      def db_time=(new_db_time)
        set_field :db_time, :number, new_db_time
      end

      def ac_only
        get_field :ac_only, :number
      end

      def ac_only=(new_ac_only)
        set_field :ac_only, :number, new_ac_only
      end

      def ac_mindepth
        get_field :ac_mindepth, :number
      end

      def ac_mindepth=(new_ac_mindepth)
        set_field :ac_mindepth, :number, new_ac_mindepth
      end

      def ac_maxdepth
        get_field :ac_maxdepth, :number
      end

      def ac_maxdepth=(new_ac_maxdepth)
        set_field :ac_maxdepth, :number,  new_ac_maxdepth
      end

      def tmpdir
        get_field :tmpdir, :string
      end

      def tmpdir=(new_tmpdir)
        set_field :tmpdir, :string, new_tmpdir
      end

      def keeptmp
        get_field :keeptmp, :number
      end

      def keeptmp=(new_keeptmp)
        set_field :keeptmp, :number, new_keeptmp
      end

      def bytecode_security
        get_field :bytecode_security, :number
      end

      def bytecode_security=(new_bytecode_security)
        set_field :bytecode_security, :number, new_bytecode_security
      end

      def bytecode_timeout
        get_field :bytecode_timeout, :number
      end

      def bytecode_timeout=(new_bytecode_timeout)
        set_field :bytecode_timeout, :number, new_bytecode_timeout
      end

      def bytecode_mode
        get_field :bytecode_mode, :number
      end

      def bytecode_mode=(new_bytecode_mode)
        set_field :bytecode_mode, :number, new_bytecode_mode
      end

      def compile!
        ClamAV.cl_engine_compile(self)
      end

      protected

      def get_field(field,type)
        error = FFI::MemoryPointer.new(:int)

        value = case type
                when :string then ClamAV.cl_engine_get_str(field,error)
                when :number then ClamAV.cl_engine_get_num(field,error)
                end

        if (errno = error.read_int) > 0
          raise(Error,Error::TYPES[errno])
        end

        return value
      end

      def set_field(field,type,value)
        Error.catch do
          case value
          when :string then ClamAV.cl_engine_set_str(field,value,error)
          when :number then ClamAV.cl_engine_set_num(field,value,error)
          else
            raise(TypeError,"field type value must be :string or :number")
          end
        end

        return value
      end

    end
  end
end
