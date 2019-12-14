<?php

namespace App\Http\Controllers;

use File;
use Illuminate\Http\Request;
use GuzzleHttp\Client;


class TwilioController extends Controller
{
    public function __construct(Client $client)
    {
        $this->http = $client;
        $this->base_url = 'https://rest.nexmo.com';
        $this->headers = [
            'Accept' => 'application/json',
        ];
    }

    public function sendSms(Request $request)
    {
        $phone = $request->phone;
        $message = $request->message;

        if (!$phone || !$message) {
            return response()->json(['error' => true, 'msg' => 'phone/message params missing']);
        }
        // Create a client with a base URI
        $response = $this->http->request('POST', $this->base_url . '/sms/json', [
            'json' => [
                'api_key' => 'a73cc235',
                'api_secret' => '4f7QN9GYWxCwIz4H',
                'to' => $phone,
                'from' => 'Nudge',
                'text' => $message,
            ]
        ]);
        if ($response->getStatusCode() === 200) {
            // return $response->getBody()->getContents();
            return response()->json(['error' => false, 'msg' => 'message sent successfully']);
        }
        return $response->getBody();
    }

    public function call(Request $request)
    {
        $message = $request->message;
        $phone = $request->phone;

        if (!$message) {
            return response()->json('message param missing');
        }
        if (!$phone) {
            return response()->json('phone param missing');
        }

        $keypair = new \Nexmo\Client\Credentials\Keypair(
            file_get_contents('private.key'),
            '394dca98-0936-47d5-872e-2fe6505a0076'
        );

        $client = new \Nexmo\Client($keypair);
        $ncco = [
            [
              'action' => 'talk',
              'voiceName' => 'Joey',
              'text' => $message,
            ]
        ];

        $call = new \Nexmo\Call\Call();
        $call->setTo($phone) // 2349840233
            ->setFrom('2348118488799')
            ->setNcco($ncco);

        $response = $client->calls()->create($call);
        return response()->json($response->getId());
    }
}
