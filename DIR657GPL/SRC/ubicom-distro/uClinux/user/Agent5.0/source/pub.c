/*=======================================================================
  
       Copyright(c) 2009, Works Systems, Inc. All rights reserved.
  
       This software is supplied under the terms of a license agreement 
       with Works Systems, Inc, and may not be copied nor disclosed except 
       in accordance with the terms of that agreement.
  
  =======================================================================*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pub.h"
#include "tr_lib.h"
#include "war_type.h"

unsigned char *hmac_sha256(const void *key, int key_len, const char *msg, int msg_len, unsigned char md[SHA256_HASH_SIZE], unsigned int *md_len)
{
    SHA256_CTX ctx;
    unsigned char k_ipad[SHA256_BLOCK_SIZE];
    unsigned char k_opad[SHA256_BLOCK_SIZE];
    unsigned char tmp_key[SHA256_HASH_SIZE];
    int i;
    /* if key is longer than 64 bytes reset it to key=SHA1(key) length to be 20 btyes*/
    if (key_len > SHA256_BLOCK_SIZE) {
    	SHA256_CTX tmp_ctx;
        SHA256_Init(&tmp_ctx);
        SHA256_Update(&tmp_ctx, (unsigned char *)key, key_len);
        //SHA256_Final(&tmp_ctx, tmp_key);
        SHA256_Final(tmp_key, &tmp_ctx);

        key = tmp_key;
        key_len = SHA256_HASH_SIZE;
    }

    memset(k_ipad, 0, sizeof(k_ipad));
    memset(k_opad, 0, sizeof(k_opad));
    memcpy(k_ipad, key, key_len);
    memcpy(k_opad, key, key_len);
    for (i = 0; i < SHA256_BLOCK_SIZE; i++)
    {
        k_ipad[i] ^= 0x36;
        k_opad[i] ^= 0x5c;
    }

    SHA256_Init(&ctx);
    SHA256_Update(&ctx, k_ipad, SHA256_BLOCK_SIZE);
    SHA256_Update(&ctx, (unsigned char *)msg, msg_len);
    SHA256_Final(md, &ctx);

    SHA256_Init(&ctx);
    SHA256_Update(&ctx, k_opad, SHA256_BLOCK_SIZE);
    SHA256_Update(&ctx, md, SHA256_HASH_SIZE);
    SHA256_Final(md, &ctx);

    *md_len = SHA256_HASH_SIZE;
    return md;
}



/*!
 * \fn __hex_print
 * \brief convert decimalist to hex, and print to screen
 * \param d: the decimalist number 
 * \return none
 */
/*the next s_PPP ,p_PPP amd PPP is for test*/
static void __hex_print(int d)
{
    char hex[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8',
        '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    printf("%c", hex[d]);
}

/*!
 * \fn _hex_print
 * \brief convert unsigned char to hex, and print to screen
 * \param d: the unsigned char number 
 * \return none
 */
static void _hex_print(unsigned char d)
{
    int tmp ;
    printf("0x");
    tmp = (d>>4) & 0xf;
    __hex_print(tmp);
    tmp = d & 0x0f;
    __hex_print(tmp);
    printf(" ");
}
/*!
 * \fn hex_print
 * \brief convert unsigned char to hex, and print to screen
 * \param input: the unsigned char data 
 * \param input_bytes: the length of unsigned char, which need to print 
 * \return none
 */
void hex_print(unsigned char *input, int input_bytes)
{
    int i;
    for(i = 0; i< input_bytes; i++)
        _hex_print(input[i]);
    printf("\n");
}

/*!
 * \fn bits_2_bytes 
 * \brief convert bits to bytes(top integral) 
 * \param bits: the bits 
 * \return the top integral
 */
int bits_2_bytes(int bits)
{
    int bytes = (bits&0x07)? ((bits)>>3) + 1: (bits)>>3;
    return bytes;
}

/*
 * the fuc used to get the EMSK from device,
 */
/*!
 * \fn get_bek 
 * \brief generate the BEK 
 * \param aes_key: where the BEK store 
 * \return 0 success -1 faild 
 */
static int get_bek(unsigned char *aes_key)
{
    /*this is a demo
      BEK = the 16 most significant (leftmost) octets of HMAC-SHA256(EMSK, "bek@wimaxforum.org")
     */
    char *emsk = NULL;
    int emsk_len;
    unsigned char md[SHA256_HASH_SIZE];
    unsigned int md_len;
    int key_len = 18;
    unsigned char key[] = {"bek@wimaxforum.org"};

    lib_get_emsk(&emsk);
    emsk_len = strlen(emsk);

    hmac_sha256(key, key_len, emsk, emsk_len, md, &md_len);
    memcpy(aes_key, md, 16);
    free(emsk);
    hex_print(aes_key, 16);

    return 0;
}

/*!
 * \fn CIPH 
 * \brief encrypt data use aes algorithm 
 * \param out: where the result store 
 * \param in: data which need be encrypted 
 * \return 0 success -1 faild 
 */
int CIPH(unsigned char *out, unsigned char *in)
{
    int res;
    unsigned char aes_key[16];
    AES_KEY key;

    memset(aes_key, 0, sizeof(aes_key));
    res = get_bek(aes_key);
    if (res != 0)
        return -1;
    res = AES_set_encrypt_key(aes_key, 128, &key);
    if (res != 0)
        return -1;
    AES_encrypt(in, out, &key);
    return 0;
}
/*!
 * \fn destroy_struct 
 * \brief destroy struct point
 * \param p: the pointer of struct need be destroyed 
 * \param r: how many struct need be destroyed 
 * \return none
 */
void destroy_struct(struct point *p, int r)
{
    int i;
    for (i = 0; i < r; i++) {
        if (p[i].a)
            free(p[i].a);
    }
    if (p) {
	free(p);
	p = NULL;
    }
}
/*!
 * \fn cover_num_2_bytes 
 * \brief covert dec to bytes 
 * \param *p: the pointer where to store result 
 * \param num: the dec 
 * \param bytes: how many bytes to convert  
 * \return none
 */
void conver_num_2_bytes(unsigned char **p, int num, int bytes)
{
    int i;
    int temp = num;
    unsigned char *tmp = NULL;
    tmp = calloc(1, bytes * sizeof(unsigned char));
    if (tmp == NULL)
       *p = NULL;
    else {
	for (i = bytes; i > 0; i--) {
	    tmp[i - 1] = 0xff & temp;
	    temp = temp >> 8;
	}
	*p = tmp;
    }
}
/*!
 * \fn alen_2_encodelen 
 * \brief computer the encode len according to  length of associate data 
 * \param Alen: the associate length  
 * \Note:  If 0 < a < (2)16-(2)8, then a is encoded as [a]16, i.e., two octets.
 * \Note:  If (2)16-(2)8 <= a < (2)32, then a is encoded as 0xff || 0xfe || [a]32, i.e., six octets.
 * \Note:  If (2)32 <= a < (2)64, then a is encoded as 0xff || 0xff || [a]64, i.e., ten octets
 * \return endode len 
 */
int alen_2_encodelen (int Alen)
{
    int encode_len;
    /*if (Alen > 0 && Alen < ADATA_level1)
        encode_len = 2;//[a]16
    else if (Alen >= ADATA_level1 && Alen < ADATA_level2)
        encode_len = 4;//0xff || 0xfe || [a]32
    else
        encode_len = 8;//0xff || 0xff || [a]6*/
    encode_len = 2;//[a]16
    return encode_len;
}
/*!
 * \fn argscat 
 * \brief cat args
 * \param *dec: the pointer where to store result  
 * \param arg1: first argument  
 * \param arg1_len: length of first argument  
 * \param arg2: second argument  
 * \param arg2_len: length of second argument  
 * \return none 
 */
void argscat(unsigned char **dec, unsigned char *arg1, int arg1_len, unsigned char *arg2, int arg2_len)
{
    unsigned char *tmp = NULL;
    tmp = calloc(1, (arg1_len+arg2_len) * sizeof(unsigned char));
    if (tmp == NULL)
	*dec = NULL;
    else {
	memcpy(tmp, arg1, arg1_len);
	memcpy(tmp+arg1_len, arg2, arg2_len);
	*dec = tmp;
    }
}
/*
 * the counter generation function to generate the counter blocks
 */
void counter_generation(struct point **p, int m, unsigned char *N, int n_len, unsigned char flag_counter)
{
    int i;
    int error = 0;
    struct point * counters = calloc(1, (m)*sizeof(struct point));
    if (counters == NULL) {
	*p = NULL;
    } else {
	for (i = 0; i < m; i++) {
	    int j;
	    int tmp = i;
	    counters[i].a = calloc(1, blockSize * sizeof(unsigned char));
	    if (counters[i].a == NULL) {
		destroy_struct(counters, i);
		error = 1;
		break;
	    } else {
		memcpy(counters[i].a, &flag_counter, 1);
		memcpy(counters[i].a+1, N, n_len);//1--n bytes
		for (j = 15 ; j > n_len; j--) {//n--15 bytes
		    *(counters[i].a+j) = 0xff & tmp;
		    tmp = tmp >> 8;
		}
	    }
	}
	if (error)
	    *p = NULL;
	else
	    *p = counters;
    }
}

/*
 * formatting function to (N, A, P) to produce the blocks B0, B1, …, Br
 */
void format_payload(unsigned char *P, int p_len, struct point **r, int *row)
{
    int size;
    int i, error = 0;
    struct point *p_blocks = NULL;

    size = (p_len)/blockSize;
    if (p_len%blockSize)
	size++;
    *row = size;
    p_blocks = calloc(1, size * sizeof(struct point));
    if (p_blocks == NULL)
	*r = NULL;
    else {
	for(i = 0; i < size; i++) {
	    p_blocks[i].a = calloc(1, blockSize * sizeof(unsigned char));
	    if (p_blocks[i].a == NULL) {
		destroy_struct(p_blocks, i);
		error = 1;
		break;
	    } else 
		memcpy(p_blocks[i].a, P+i*blockSize, i==size-1? p_len%blockSize: blockSize);
	}
	if (error)
	    *r = NULL;
	else
	    *r = p_blocks;
    }
}

void format_associated_data(unsigned char *A, int a_len, struct point **p, int *row)
{
    int i;
    int size;
    int error = 0;
    int encode_len;
    struct point *a_blocks = NULL;
    unsigned char *result_t = NULL;//free
    unsigned char *result = NULL;//result free
    unsigned char *result_fin = NULL;//free

    encode_len = alen_2_encodelen(a_len);
    conver_num_2_bytes(&result_t, a_len, encode_len);
    if (result_t == NULL)
	*p = NULL;
    else {
	argscat(&result, result_t, encode_len, A, a_len);
	free(result_t);
	if (result == NULL) {
	    *p = NULL;
	} else {
	    size = (encode_len + a_len)/blockSize;
	    if ((encode_len + a_len)%blockSize)
		size++;
	    *row = size;
	    result_fin = calloc(1, size * blockSize * sizeof(unsigned char));
	    if (result_fin == NULL) {
		*p = NULL;
	    } else {
		memcpy(result_fin, result, encode_len + a_len);
		a_blocks = calloc(1, size * sizeof(struct point));
		if (a_blocks == NULL) {
		    *p = NULL;
		} else {
		    for( i = 0; i < size; i++) {
			a_blocks[i].a = calloc(1, blockSize * sizeof(unsigned char));
			if (a_blocks[i].a == NULL) {
			    destroy_struct(a_blocks, i);
			    error = 1;
			} else
			    memcpy(a_blocks[i].a, result_fin+i*blockSize, blockSize);
		    }
		    if (error)
			*p = NULL;
		    else
			*p = a_blocks;
		}
		free(result_fin);
	    }
	    free(result);//free result
	}
    }
}

