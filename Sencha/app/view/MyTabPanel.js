/*
 * File: app/view/MyTabPanel.js
 *
 * This file was generated by Sencha Architect version 2.0.0.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Sencha Touch 2.0.x library, under independent license.
 * License of Sencha Architect does not include license for Sencha Touch 2.0.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('MyApp.view.MyTabPanel', {
    extend: 'Ext.tab.Panel',

    config: {
        items: [
            {
                xtype: 'tabpanel',
                title: 'News',
                iconCls: 'info',
                items: [
                    {
                        xtype: 'list',
                        itemId: 'OfficialList',
                        itemTpl: [
                            '<table width="95%"><tr><td colspan="3"><div class="newsDate x-tabbar-dark">{created_at_display}</div></td></tr><tr><td width="25px"><div class="authorImage"><img src="{profile_url}"></img></div></td><td align="left"><div class="newsItem"><div>{body}</div><div class="author"><img src="{provider_img}"></img>{author}</div></div></td></tr></table><div class="disclosure"><img src="assets/images/disclosure.png"></img></div>'
                        ],
                        store: 'OfficialNewsStore',
                        title: 'TIHC Official',
                        plugins: [
                            {
                                type: 'listpaging'
                            },
                            {
                                type: 'pullrefresh'
                            }
                        ]
                    },
                    {
                        xtype: 'list',
                        itemId: 'FanFeed',
                        itemTpl: [
                            '<table width="95%"><tr><td colspan="3"><div class="newsDate x-tabbar-dark">{created_at_display}</div></td></tr><tr><td width="25px"><div class="authorImage"><img src="{profile_url}"></img></div></td><td align="left"><div class="newsItem"><div>{body}</div><div class="author"><img src="{provider_img}"></img>{author}</div></div></td></tr></table><div class="disclosure"><img src="assets/images/disclosure.png"></img></div>'
                        ],
                        store: 'FanNewsStore',
                        title: 'Fan Feed',
                        plugins: [
                            {
                                type: 'listpaging'
                            },
                            {
                                type: 'pullrefresh'
                            }
                        ]
                    }
                ],
                tabBar: {
                    docked: 'top',
                    layout: {
                        align: 'center',
                        pack: 'center',
                        type: 'hbox'
                    }
                }
            },
            {
                xtype: 'navigationview',
                id: 'NavigationView',
                title: 'Schedule',
                iconCls: 'time',
                items: [
                    {
                        xtype: 'list',
                        itemTpl: [
                            '<div><img class="icon" src="{icon_url}"></img> {artist_name}<span class="setTime">{start_time_display} - {end_time_display}</span></div>'
                        ],
                        store: 'MyJsonStore',
                        grouped: true,
                        title: 'Schedule'
                    }
                ]
            },
            {
                xtype: 'tabpanel',
                title: 'Photo Pit',
                iconCls: 'favorites',
                tabBar: {
                    docked: 'top',
                    layout: {
                        align: 'center',
                        pack: 'center',
                        type: 'hbox'
                    }
                },
                items: [
                    {
                        xtype: 'list',
                        itemTpl: [
                            '<table width="100%"><tr><td><div class="photoPitDate x-tabbar-dark">{created_at_display}</div></td><tr><td><img src="{url}"></img></td></tr><tr><td><div class="photoPitAuthorContainer"><div class="authorImage"><img src="{profile_url}"></img></div><div class="author">{author}</div><div>{body}</div></div></td></tr></table>'
                        ],
                        store: 'OfficialPhotoPit',
                        allowDeselect: false,
                        disableSelection: true,
                        title: 'TIHC Official',
                        plugins: [
                            {
                                type: 'listpaging'
                            },
                            {
                                type: 'pullrefresh'
                            }
                        ]
                    },
                    {
                        xtype: 'list',
                        itemTpl: [
                            '<table width="100%"><tr><td><div class="photoPitDate x-tabbar-dark">{created_at_display}</div></td><tr><td><img src="{url}"></img></td></tr><tr><td><div class="photoPitAuthorContainer"><div class="authorImage"><img src="{profile_url}"></img></div><div class="author">{author}</div><div>{body}</div></div></td></tr></table>'
                        ],
                        store: 'FanPhotoPit',
                        disableSelection: true,
                        title: 'Fan Feed',
                        plugins: [
                            {
                                type: 'listpaging'
                            },
                            {
                                type: 'pullrefresh'
                            }
                        ]
                    }
                ]
            },
            {
                xtype: 'list',
                itemId: 'mylist5',
                itemTpl: [
                    '<table><tr><td><div class="moreImage"><img src="{iconUrl}"></img></div></td><td>{text}</td></tr></table><div class="disclosure"><img src="assets/images/disclosure.png"></img></div>'
                ],
                store: 'MoreStore',
                title: 'More',
                iconCls: 'more'
            }
        ],
        tabBar: {
            docked: 'bottom'
        },
        listeners: [
            {
                fn: 'OfficialListItemTap',
                event: 'itemtap',
                delegate: '#OfficialList'
            },
            {
                fn: 'FanFeedItemTap',
                event: 'itemtap',
                delegate: '#FanFeed'
            },
            {
                fn: 'onMylist5ItemTap',
                event: 'itemtap',
                delegate: '#mylist5'
            }
        ]
    },

    OfficialListItemTap: function(dataview, index, target, record, e, options) {
        window.open(record.get('url'));
    },

    FanFeedItemTap: function(dataview, index, target, record, e, options) {
        window.open(record.get('url'));
    },

    onMylist5ItemTap: function(dataview, index, target, record, e, options) {
        window.open(record.get('url'));
    }

});