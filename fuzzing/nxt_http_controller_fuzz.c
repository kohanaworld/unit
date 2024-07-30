/*
 * Copyright (C) NGINX, Inc.
 */

#include <nxt_main.h>

/* DO NOT TRY THIS AT HOME! */
#include "nxt_controller.c"


#define KMININPUTLENGTH 2
#define KMAXINPUTLENGTH 1024


extern int LLVMFuzzerInitialize(int *argc, char ***argv);
extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);


extern char  **environ;


int
LLVMFuzzerInitialize(int *argc, char ***argv)
{
    nxt_int_t  ret;

    if (nxt_lib_start("fuzzing", NULL, &environ) != NXT_OK) {
        return NXT_ERROR;
    }

    ret = nxt_http_fields_hash(&nxt_controller_fields_hash,
                               nxt_controller_request_fields,
                               nxt_nitems(nxt_controller_request_fields));
    if (ret != NXT_OK) {
        return NXT_ERROR;
    }

    return 0;
}


int
LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
{
    nxt_mp_t                  *mp;
    nxt_buf_mem_t             buf;
    nxt_controller_request_t  *r_controller;
    nxt_http_request_parse_t  rp;

    if (size < KMININPUTLENGTH || size > KMAXINPUTLENGTH) {
        return 0;
    }

    mp = nxt_mp_create(1024, 128, 256, 32);
    if (mp == NULL) {
        return 0;
    }

    nxt_memzero(&rp, sizeof(nxt_http_request_parse_t));
    if (nxt_http_parse_request_init(&rp, mp) != NXT_OK) {
        goto failed;
    }

    buf.start = (u_char *)data;
    buf.end = (u_char *)data + size;
    buf.pos = buf.start;
    buf.free = buf.end;

    if (nxt_http_parse_request(&rp, &buf) != NXT_DONE) {
        goto failed;
    }

    r_controller = nxt_mp_zget(mp, sizeof(nxt_controller_request_t));

    if (r_controller == NULL) {
        goto failed;
    }

    r_controller->conn = nxt_mp_zget(mp, sizeof(nxt_conn_t));
    if (r_controller->conn == NULL) {
        goto failed;
    }

    nxt_main_log.level = NXT_LOG_ALERT;
    r_controller->conn->log = nxt_main_log;

    nxt_http_fields_process(rp.fields, &nxt_controller_fields_hash,
                            r_controller);

failed:

    nxt_mp_destroy(mp);

    return 0;
}
