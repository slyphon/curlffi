module CurlFFI
  module Constants
    CURLVERSION_NOW       = 3

    # constants defined in curl.h
    CURL_GLOBAL_SSL       = (1 << 0)
    CURL_GLOBAL_WIN32     = (1 << 1)
    CURL_GLOBAL_ALL       = (CURL_GLOBAL_SSL|CURL_GLOBAL_WIN32)
    CURL_GLOBAL_NOTHING   = 0
    CURL_GLOBAL_DEFAULT   = CURL_GLOBAL_ALL

    # info constants
    CURLINFO_TEXT         = 0
    CURLINFO_HEADER_IN    = 1
    CURLINFO_HEADER_OUT   = 2
    CURLINFO_DATA_IN      = 3
    CURLINFO_DATA_OUT     = 4
    CURLINFO_SSL_DATA_IN  = 5
    CURLINFO_SSL_DATA_OUT = 6
    CURLINFO_END          = 7

    # info arg types
    CURLINFO_STRING       = 0x100000
    CURLINFO_LONG         = 0x200000
    CURLINFO_DOUBLE       = 0x300000
    CURLINFO_SLIST        = 0x400000
    CURLINFO_MASK         = 0x0fffff
    CURLINFO_TYPEMASK     = 0xf00000

    # info constants
    CURLINFO_EFFECTIVE_URL            = CURLINFO_STRING + 1
    CURLINFO_RESPONSE_CODE            = CURLINFO_LONG   + 2
    CURLINFO_TOTAL_TIME               = CURLINFO_DOUBLE + 3
    CURLINFO_NAMELOOKUP_TIME          = CURLINFO_DOUBLE + 4
    CURLINFO_CONNECT_TIME             = CURLINFO_DOUBLE + 5
    CURLINFO_PRETRANSFER_TIME         = CURLINFO_DOUBLE + 6
    CURLINFO_SIZE_UPLOAD              = CURLINFO_DOUBLE + 7
    CURLINFO_SIZE_DOWNLOAD            = CURLINFO_DOUBLE + 8
    CURLINFO_SPEED_DOWNLOAD           = CURLINFO_DOUBLE + 9
    CURLINFO_SPEED_UPLOAD             = CURLINFO_DOUBLE + 10
    CURLINFO_HEADER_SIZE              = CURLINFO_LONG   + 11
    CURLINFO_REQUEST_SIZE             = CURLINFO_LONG   + 12
    CURLINFO_SSL_VERIFYRESULT         = CURLINFO_LONG   + 13
    CURLINFO_FILETIME                 = CURLINFO_LONG   + 14
    CURLINFO_CONTENT_LENGTH_DOWNLOAD  = CURLINFO_DOUBLE + 15
    CURLINFO_CONTENT_LENGTH_UPLOAD    = CURLINFO_DOUBLE + 16
    CURLINFO_STARTTRANSFER_TIME       = CURLINFO_DOUBLE + 17
    CURLINFO_CONTENT_TYPE             = CURLINFO_STRING + 18
    CURLINFO_REDIRECT_TIME            = CURLINFO_DOUBLE + 19
    CURLINFO_REDIRECT_COUNT           = CURLINFO_LONG   + 20
    CURLINFO_PRIVATE                  = CURLINFO_STRING + 21
    CURLINFO_HTTP_CONNECTCODE         = CURLINFO_LONG   + 22
    CURLINFO_HTTPAUTH_AVAIL           = CURLINFO_LONG   + 23
    CURLINFO_PROXYAUTH_AVAIL          = CURLINFO_LONG   + 24
    CURLINFO_OS_ERRNO                 = CURLINFO_LONG   + 25
    CURLINFO_NUM_CONNECTS             = CURLINFO_LONG   + 26
    CURLINFO_SSL_ENGINES              = CURLINFO_SLIST  + 27
    CURLINFO_COOKIELIST               = CURLINFO_SLIST  + 28
    CURLINFO_LASTSOCKET               = CURLINFO_LONG   + 29
    CURLINFO_FTP_ENTRY_PATH           = CURLINFO_STRING + 30


    # curl option types
    COTYPE_LONG           = 0
    COTYPE_OBJECTPOINT    = 10_000
    COTYPE_FUNCTIONPOINT  = 20_000
    COTYPE_OFF_T          = 30_000

    # options
    CURLOPT_FILE                        = COTYPE_OBJECTPOINT    + 1
    CURLOPT_URL                         = COTYPE_OBJECTPOINT    + 2
    CURLOPT_PORT                        = COTYPE_LONG           + 3
    CURLOPT_PROXY                       = COTYPE_OBJECTPOINT    + 4
    CURLOPT_USERPWD                     = COTYPE_OBJECTPOINT    + 5
    CURLOPT_PROXYUSERPWD                = COTYPE_OBJECTPOINT    + 6
    CURLOPT_RANGE                       = COTYPE_OBJECTPOINT    + 7
    CURLOPT_INFILE                      = COTYPE_OBJECTPOINT    + 9
    CURLOPT_ERRORBUFFER                 = COTYPE_OBJECTPOINT    + 10
    CURLOPT_WRITEFUNCTION               = COTYPE_FUNCTIONPOINT  + 11
    CURLOPT_READFUNCTION                = COTYPE_FUNCTIONPOINT  + 12
    CURLOPT_TIMEOUT                     = COTYPE_LONG           + 13
    CURLOPT_INFILESIZE                  = COTYPE_LONG           + 14
    CURLOPT_POSTFIELDS                  = COTYPE_OBJECTPOINT    + 15
    CURLOPT_REFERER                     = COTYPE_OBJECTPOINT    + 16
    CURLOPT_FTPPORT                     = COTYPE_OBJECTPOINT    + 17
    CURLOPT_USERAGENT                   = COTYPE_OBJECTPOINT    + 18
    CURLOPT_LOW_SPEED_TIME              = COTYPE_LONG           + 20
    CURLOPT_RESUME_FROM                 = COTYPE_LONG           + 21
    CURLOPT_COOKIE                      = COTYPE_OBJECTPOINT    + 22
    CURLOPT_HTTPHEADER                  = COTYPE_OBJECTPOINT    + 23
    CURLOPT_HTTPPOST                    = COTYPE_OBJECTPOINT    + 24
    CURLOPT_SSLCERT                     = COTYPE_OBJECTPOINT    + 25
    CURLOPT_SSLCERTPASSWD               = COTYPE_OBJECTPOINT    + 26
    CURLOPT_SSLKEYPASSWD                = COTYPE_OBJECTPOINT    + 26
    CURLOPT_CRLF                        = COTYPE_LONG           + 27
    CURLOPT_QUOTE                       = COTYPE_OBJECTPOINT    + 28
    CURLOPT_WRITEHEADER                 = COTYPE_OBJECTPOINT    + 29
    CURLOPT_COOKIEFILE                  = COTYPE_OBJECTPOINT    + 31
    CURLOPT_SSLVERSION                  = COTYPE_LONG           + 32
    CURLOPT_TIMECONDITION               = COTYPE_LONG           + 33
    CURLOPT_TIMEVALUE                   = COTYPE_LONG           + 34
    CURLOPT_CUSTOMREQUEST               = COTYPE_OBJECTPOINT    + 36
    CURLOPT_STDERR                      = COTYPE_OBJECTPOINT    + 37
    CURLOPT_POSTQUOTE                   = COTYPE_OBJECTPOINT    + 39
    CURLOPT_WRITEINFO                   = COTYPE_OBJECTPOINT    + 40
    CURLOPT_VERBOSE                     = COTYPE_LONG           + 41
    CURLOPT_HEADER                      = COTYPE_LONG           + 42
    CURLOPT_NOPROGRESS                  = COTYPE_LONG           + 43
    CURLOPT_NOBODY                      = COTYPE_LONG           + 44
    CURLOPT_FAILONERROR                 = COTYPE_LONG           + 45
    CURLOPT_UPLOAD                      = COTYPE_LONG           + 46
    CURLOPT_POST                        = COTYPE_LONG           + 47
    CURLOPT_FTPLISTONLY                 = COTYPE_LONG           + 48
    CURLOPT_FTPAPPEND                   = COTYPE_LONG           + 50
    CURLOPT_NETRC                       = COTYPE_LONG           + 51
    CURLOPT_FOLLOWLOCATION              = COTYPE_LONG           + 52
    CURLOPT_TRANSFERTEXT                = COTYPE_LONG           + 53
    CURLOPT_PUT                         = COTYPE_LONG           + 54
    CURLOPT_PROGRESSFUNCTION            = COTYPE_FUNCTIONPOINT  + 56
    CURLOPT_PROGRESSDATA                = COTYPE_OBJECTPOINT    + 57
    CURLOPT_AUTOREFERER                 = COTYPE_LONG           + 58
    CURLOPT_PROXYPORT                   = COTYPE_LONG           + 59
    CURLOPT_POSTFIELDSIZE               = COTYPE_LONG           + 60
    CURLOPT_HTTPPROXYTUNNEL             = COTYPE_LONG           + 61
    CURLOPT_INTERFACE                   = COTYPE_OBJECTPOINT    + 62
    CURLOPT_SSL_VERIFYPEER              = COTYPE_LONG           + 64
    CURLOPT_CAINFO                      = COTYPE_OBJECTPOINT    + 65
    CURLOPT_MAXREDIRS                   = COTYPE_LONG           + 68
    CURLOPT_FILETIME                    = COTYPE_LONG           + 69
    CURLOPT_TELNETOPTIONS               = COTYPE_OBJECTPOINT    + 70
    CURLOPT_MAXCONNECTS                 = COTYPE_LONG           + 71
    CURLOPT_CLOSEPOLICY                 = COTYPE_LONG           + 72
    CURLOPT_FRESH_CONNECT               = COTYPE_LONG           + 74
    CURLOPT_FORBID_REUSE                = COTYPE_LONG           + 75
    CURLOPT_RANDOM_FILE                 = COTYPE_OBJECTPOINT    + 76
    CURLOPT_EGDSOCKET                   = COTYPE_OBJECTPOINT    + 77
    CURLOPT_CONNECTTIMEOUT              = COTYPE_LONG           + 78
    CURLOPT_HEADERFUNCTION              = COTYPE_FUNCTIONPOINT  + 79
    CURLOPT_HTTPGET                     = COTYPE_LONG           + 80
    CURLOPT_SSL_VERIFYHOST              = COTYPE_LONG           + 81
    CURLOPT_COOKIEJAR                   = COTYPE_OBJECTPOINT    + 82
    CURLOPT_SSL_CIPHER_LIST             = COTYPE_OBJECTPOINT    + 83
    CURLOPT_HTTP_VERSION                = COTYPE_LONG           + 84
    CURLOPT_FTP_USE_EPSV                = COTYPE_LONG           + 85
    CURLOPT_SSLCERTTYPE                 = COTYPE_OBJECTPOINT    + 86
    CURLOPT_SSLKEY                      = COTYPE_OBJECTPOINT    + 87
    CURLOPT_SSLKEYTYPE                  = COTYPE_OBJECTPOINT    + 88
    CURLOPT_SSLENGINE                   = COTYPE_OBJECTPOINT    + 89
    CURLOPT_SSLENGINE_DEFAULT           = COTYPE_LONG           + 90
    CURLOPT_DNS_USE_GLOBAL_CACHE        = COTYPE_LONG           + 91
    CURLOPT_DNS_CACHE_TIMEOUT           = COTYPE_LONG           + 92
    CURLOPT_PREQUOTE                    = COTYPE_OBJECTPOINT    + 93
    CURLOPT_DEBUGFUNCTION               = COTYPE_FUNCTIONPOINT  + 94
    CURLOPT_DEBUGDATA                   = COTYPE_OBJECTPOINT    + 95
    CURLOPT_COOKIESESSION               = COTYPE_LONG           + 96
    CURLOPT_CAPATH                      = COTYPE_OBJECTPOINT    + 97
    CURLOPT_BUFFERSIZE                  = COTYPE_LONG           + 98
    CURLOPT_NOSIGNAL                    = COTYPE_LONG           + 99
    CURLOPT_SHARE                       = COTYPE_OBJECTPOINT    + 100
    CURLOPT_PROXYTYPE                   = COTYPE_LONG           + 101
    CURLOPT_ENCODING                    = COTYPE_OBJECTPOINT    + 102
    CURLOPT_PRIVATE                     = COTYPE_OBJECTPOINT    + 103
    CURLOPT_UNRESTRICTED_AUTH           = COTYPE_LONG           + 105
    CURLOPT_FTP_USE_EPRT                = COTYPE_LONG           + 106
    CURLOPT_HTTPAUTH                    = COTYPE_LONG           + 107
    CURLOPT_SSL_CTX_FUNCTION            = COTYPE_FUNCTIONPOINT  + 108
    CURLOPT_SSL_CTX_DATA                = COTYPE_OBJECTPOINT    + 109
    CURLOPT_FTP_CREATE_MISSING_DIRS     = COTYPE_LONG           + 110
    CURLOPT_PROXYAUTH                   = COTYPE_LONG           + 111
    CURLOPT_IPRESOLVE                   = COTYPE_LONG           + 113
    CURLOPT_MAXFILESIZE                 = COTYPE_LONG           + 114
    CURLOPT_INFILESIZE_LARGE            = COTYPE_OFF_T          + 115
    CURLOPT_RESUME_FROM_LARGE           = COTYPE_OFF_T          + 116
    CURLOPT_MAXFILESIZE_LARGE           = COTYPE_OFF_T          + 117
    CURLOPT_NETRC_FILE                  = COTYPE_OBJECTPOINT    + 118
    CURLOPT_FTP_SSL                     = COTYPE_LONG           + 119
    CURLOPT_POSTFIELDSIZE_LARGE         = COTYPE_OFF_T          + 120
    CURLOPT_TCP_NODELAY                 = COTYPE_LONG           + 121
    CURLOPT_FTPSSLAUTH                  = COTYPE_LONG           + 129
    CURLOPT_IOCTLFUNCTION               = COTYPE_FUNCTIONPOINT  + 130
    CURLOPT_IOCTLDATA                   = COTYPE_OBJECTPOINT    + 131
    CURLOPT_FTP_ACCOUNT                 = COTYPE_OBJECTPOINT    + 134
    CURLOPT_COOKIELIST                  = COTYPE_OBJECTPOINT    + 135
    CURLOPT_IGNORE_CONTENT_LENGTH       = COTYPE_LONG           + 136
    CURLOPT_FTP_SKIP_PASV_IP            = COTYPE_LONG           + 137
    CURLOPT_FTP_FILEMETHOD              = COTYPE_LONG           + 138
    CURLOPT_LOCALPORT                   = COTYPE_LONG           + 139
    CURLOPT_LOCALPORTRANGE              = COTYPE_LONG           + 140
    CURLOPT_CONNECT_ONLY                = COTYPE_LONG           + 141
    CURLOPT_CONV_FROM_NETWORK_FUNCTION  = COTYPE_FUNCTIONPOINT  + 142
    CURLOPT_CONV_TO_NETWORK_FUNCTION    = COTYPE_FUNCTIONPOINT  + 143
    CURLOPT_MAX_SEND_SPEED_LARGE        = COTYPE_OFF_T          + 145
    CURLOPT_MAX_RECV_SPEED_LARGE        = COTYPE_OFF_T          + 146
    CURLOPT_FTP_ALTERNATIVE_TO_USER     = COTYPE_OBJECTPOINT    + 147
    CURLOPT_SOCKOPTFUNCTION             = COTYPE_FUNCTIONPOINT  + 148
    CURLOPT_SOCKOPTDATA                 = COTYPE_OBJECTPOINT    + 149
    CURLOPT_SSL_SESSIONID_CACHE         = COTYPE_LONG           + 150
    CURLOPT_SSH_AUTH_TYPES              = COTYPE_LONG           + 151
    CURLOPT_SSH_PUBLIC_KEYFILE          = COTYPE_OBJECTPOINT    + 152
    CURLOPT_SSH_PRIVATE_KEYFILE         = COTYPE_OBJECTPOINT    + 153
    CURLOPT_FTP_SSL_CCC                 = COTYPE_LONG           + 154
    CURLOPT_TIMEOUT_MS                  = COTYPE_LONG           + 155
    CURLOPT_CONNECTTIMEOUT_MS           = COTYPE_LONG           + 156
    CURLOPT_HTTP_TRANSFER_DECODING      = COTYPE_LONG           + 157
    CURLOPT_HTTP_CONTENT_DECODING       = COTYPE_LONG           + 158

    # these are synonymous
    CURLOPT_WRITEDATA     = CURLOPT_FILE
    CURLOPT_READDATA      = CURLOPT_INFILE
    CURLOPT_HEADERDATA    = CURLOPT_WRITEHEADER

    # status
    CURLE_OK              = 0


    # http version enum values
    CURL_HTTP_VERSION_NONE  = 0
    CURL_HTTP_VERSION_1_0   = 1
    CURL_HTTP_VERSION_1_1   = 2
  end
end

