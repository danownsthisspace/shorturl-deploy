(ns shorturl.env
  (:require [clojure.java.io :as jio]))

(def envvars
  (if (.exists (clojure.java.io/file "env.edn"))
    (clojure.edn/read-string (slurp "env.edn"))
    {}))

(defn env [k]
  (or (k envvars) (System/getenv (name k))))

(comment
  (name :HOME)
  (env :HOME)
  (System/getenv "HOME"))