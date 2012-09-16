require 'ffi/clamav/library'
require 'ffi/clamav/types'

require 'ffi'

module FFI
  module ClamAV
    class Error < StandardError

      TYPES = ClamAV.enum_type(:cl_error_t)

      attr_reader :type

      def initialize(type)
        super(ClamAV.cl_strerror(type))
      end

      #
      # Catches errors from ClamAV.
      #
      # @yield []
      #
      # @return [true]
      #   The ClamAV function was successful.
      #
      # @raise [Error]
      #   If the ClamAV function returned an error, an Error exception will be
      #   raised.
      #
      def self.catch
        case (error = yield)
        when :clean, :success then return true
        else                       raise(self,error,caller[1..-1])
        end
      end

    end
  end
end
