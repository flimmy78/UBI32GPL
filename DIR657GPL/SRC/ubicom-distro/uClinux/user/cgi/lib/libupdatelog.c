#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "update_log_table.h"
#include "nvram.h"
#include "shvar.h"
#include "sutil.h"
#include "debug.h"

char *hostname = NULL;
log_dynamic_table_t log_dynamic_table[MAX_LOG_LENGTH];

void fill_log_into_structure(char *time, char *type, char *messages, int index_t)
{
	int i;
	for(i = 0; i < strlen(messages);i++)
	{
		if(messages[i] == '"')
			messages[i] = ' ';
		else if(messages[i] == '<')
			messages[i] = '\'';
		else if(messages[i] == '>')
			messages[i] = '\'';
	}
	strcpy(log_dynamic_table[index_t].time , time);
	log_dynamic_table[index_t].type = type;
	strcpy(log_dynamic_table[index_t].message , messages);
}

int check_log_type(char *input, char *type, int index_t)
{
	char *time = NULL;
	char *messages=NULL;
	char *type_index=NULL;
	int len_time, len_message, len_type;
	char *tmpMessages=NULL;
	
	hostname= nvram_safe_get("hostname");

	if(strstr(input,type) != NULL)
	{
		tmpMessages = strstr(input, type) + strlen(type) +1;
		if(strchr(tmpMessages,':') == 0)
			return 0;
		if (strstr(tmpMessages,"init") != 0)
			return 0;
		messages    = strchr(tmpMessages,':') + 1;
		len_message = strlen(messages);
		messages[len_message-1] = '\0';
		if(strstr(input, hostname) == 0)
			return 0;
		type_index = strstr(input, hostname) + strlen(hostname) +1 ;
		len_type = strchr(type_index, ' ') - type_index;
		type_index[len_type]= '\0';
		time = input;
		len_time = strstr(input, hostname ) - time ;
		time[len_time] = '\0';

		fill_log_into_structure(time,type,messages,index_t);
		return 1;
	}
	return 0;
}

int update_log_table(int log_system_activity, int log_debug_information, int log_attacks, int log_dropped_packets, int log_notice)
{

	FILE *fp;
	char buffer[log_length] = "";
	char cmd[128];
	int index_t = 0;

	hostname= nvram_safe_get("hostname");

/* jimmy modified for IPC syslog */
	sprintf(cmd, "logread | tac > %s ", LOG_FILE_HTTP);
	//sprintf(cmd, "logread", LOG_FILE_HTTP);
	system(cmd);
	
//------------
	if((fp = fopen(LOG_FILE_HTTP, "r+")) == NULL){
		return 0;
	} else	{
		while(fgets(buffer,log_length,fp)) {
			if(log_notice == 1 ) {
				index_t += check_log_type(buffer, "notice", index_t);
			}

			if(log_debug_information == 1) {
				index_t += check_log_type(buffer, "debug", index_t);
			}

			if(log_system_activity == 1) {
				index_t += check_log_type(buffer, "info", index_t);
			}

			if(log_attacks == 1) {
				index_t += check_log_type(buffer, "attack", index_t);
			}

			if(log_dropped_packets == 1) {
				index_t += check_log_type(buffer, "dropped", index_t);
			}

			if(index_t > MAX_LOG_LENGTH) 
				index_t = MAX_LOG_LENGTH;
		}
	}
	fclose(fp);


	if((fp = fopen(LOG_FILE,"r+")) == NULL){
		return 0;
	}	
	else	
	{

		while(fgets(buffer,log_length,fp))
		{
			if(log_attacks == 1)
			{
				index_t += check_log_type(buffer,"attack", index_t);
			}
			if(index_t > MAX_LOG_LENGTH) 
				index_t = MAX_LOG_LENGTH;
		}
	}

	fclose(fp);
	return index_t;
}
