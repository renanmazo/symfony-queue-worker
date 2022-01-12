<?php

namespace App\Messaging;

use Symfony\Component\Messenger\Handler\MessageHandlerInterface;

class MessageHandler implements MessageHandlerInterface
{
    public function __invoke(SimpleNotification $message)
    {
        //Do your stuff
        echo $message->getContent();
    }
}