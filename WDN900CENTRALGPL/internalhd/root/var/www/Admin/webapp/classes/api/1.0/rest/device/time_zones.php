<?php
require_once('NasXmlWriter.class.php');
require_once('authenticate.php');
require_once('timeZones.php');
require_once('logMessages.php');

class Time_zones{
	var $logObj;

    function Time_zones(){
		$this->logObj = new LogMessages();
	}


    function get($urlPath, $queryParams=null, $ouputFormat='xml'){
        if(!authenticateAsOwner($queryParams))
        {
            header("HTTP/1.0 401 Unauthorized");
            return;
        }

        header("Content-Type: application/xml");
        
        $timeZonesObj = new TimeZones();
        $result = $timeZonesObj->getTimeZones();

        if($result !== NULL){
            $xml = new NasXmlWriter();
            $xml->push('time_zones');
            foreach($result as $name => $description){
                $xml->push('time_zone');
                $xml->element('name', $name);
                $xml->element('description', $description);
                $xml->pop();
            }
            $xml->pop();
            echo $xml->getXml();
			$this->logObj->LogData('OUTPUT', get_class($this),  __FUNCTION__,  'SUCCESS');
		} else {
            //Failed to collect info
            header("HTTP/1.0 500 Internal Server Error");
			$this->logObj->LogData('OUTPUT', get_class($this),  __FUNCTION__,  'SERVER_ERROR');
		}
    }


    function put($urlPath, $queryParams=null, $ouputFormat='xml'){
        header("Allow: GET");
        header("HTTP/1.0 405 Method Not Allowed");
    }

    function post($urlPath, $queryParams=null, $ouputFormat='xml'){
        header("Allow: GET");
        header("HTTP/1.0 405 Method Not Allowed");
    }

    function delete($urlPath, $queryParams=null, $ouputFormat='xml'){
        header("Allow: GET");
        header("HTTP/1.0 405 Method Not Allowed");
    }

}

/*
 * Local variables:
 *  indent-tabs-mode: nil
 *  c-basic-offset: 4
 *  c-indent-level: 4
 *  tab-width: 4
 * End:
 */
?>
