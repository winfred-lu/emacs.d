;; Use elpa behind a proxy. Configure host and port:
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|192\\.168\\..*\\)")
        ("http" . "proxy.com:8080")
        ("https" . "proxy.com:8080")))

;; Deal with authentication:
(setq url-http-proxy-basic-auth-storage
      (list (list "proxy.com:8080"
                  (cons "Input your LDAP UID !"
                        (base64-encode-string "LOGIN:PASSWORD")))))

;; There is a bug for emacs < 28.1 in url-http with the function url-https-proxy-connect,
;; causing all https calls through an authenticating proxy to fail.
;; See https://debbugs.gnu.org/cgi/bugreport.cgi?bug=42422.
;; As a workaround, override the function with the fixed version:
(when (< emacs-major-version 28)
  (with-eval-after-load 'url-http
    (defun url-https-proxy-connect (connection)
      (setq url-http-after-change-function 'url-https-proxy-after-change-function)
      (process-send-string connection
                           (format
                            (concat "CONNECT %s:%d HTTP/1.1\r\n"
                                    "Host: %s\r\n"
                                    (let ((proxy-auth (let ((url-basic-auth-storage
                                                             'url-http-proxy-basic-auth-storage))
                                                        (url-get-authentication url-http-proxy nil 'any nil))))
                                      (if proxy-auth (concat "Proxy-Authorization: " proxy-auth "\r\n")))
                                    "\r\n")
                            (url-host url-current-object)
                            (or (url-port url-current-object)
                                url-https-default-port)
                            (url-host url-current-object))))))
