//
//  ios_pj_ice.h
//  iosrtcua
//
//  Created by Reeonce on 5/25/16.
//

#ifndef ios_pj_ice_h
#define ios_pj_ice_h

typedef struct pj_ice_strans_comp
{
    pj_ice_strans	*ice_st;	/**< ICE stream transport.	*/
    unsigned		 comp_id;	/**< Component ID.		*/
    
    pj_stun_sock	*stun_sock;	/**< STUN transport.		*/
    pj_turn_sock	*turn_sock;	/**< TURN relay transport.	*/
    pj_bool_t		 turn_log_off;	/**< TURN loggin off?		*/
    unsigned		 turn_err_cnt;	/**< TURN disconnected count.	*/
    
    unsigned		 cand_cnt;	/**< # of candidates/aliaes.	*/
    pj_ice_sess_cand	 cand_list[PJ_ICE_ST_MAX_CAND];	/**< Cand array	*/
    
    unsigned		 default_cand;	/**< Default candidate.		*/
    
} pj_ice_strans_comp;


/**
 * This structure represents the ICE stream transport.
 */
struct pj_ice_strans
{
    char		    *obj_name;	/**< Log ID.			*/
    pj_pool_t		    *pool;	/**< Pool used by this object.	*/
    void		    *user_data;	/**< Application data.		*/
    pj_ice_strans_cfg	     cfg;	/**< Configuration.		*/
    pj_ice_strans_cb	     cb;	/**< Application callback.	*/
    pj_grp_lock_t	    *grp_lock;  /**< Group lock.		*/
    
    pj_ice_strans_state	     state;	/**< Session state.		*/
    pj_ice_sess		    *ice;	/**< ICE session.		*/
    pj_time_val		     start_time;/**< Time when ICE was started	*/
    
    unsigned		     comp_cnt;	/**< Number of components.	*/
    pj_ice_strans_comp	   **comp;	/**< Components array.		*/
    
    pj_timer_entry	     ka_timer;	/**< STUN keep-alive timer.	*/
    
    pj_bool_t		     destroy_req;/**< Destroy has been called?	*/
    pj_bool_t		     cb_called;	/**< Init error callback called?*/
};


enum oa_role
{
    ROLE_NONE,
    ROLE_OFFERER,
    ROLE_ANSWERER
};

struct sdp_state
{
    unsigned		match_comp_cnt;	/* Matching number of components    */
    pj_bool_t		ice_mismatch;	/* Address doesn't match candidates */
    pj_bool_t		ice_restart;	/* Offer to restart ICE		    */
    pj_ice_sess_role	local_role;	/* Our role			    */
};

struct transport_ice
{
    pjmedia_transport	 base;
    pj_pool_t		*pool;
    int			 af;
    unsigned		 options;	/**< Transport options.		    */
    
    unsigned		 comp_cnt;
    pj_ice_strans	*ice_st;
    
    pjmedia_ice_cb	 cb;
    unsigned		 media_option;
    
    pj_bool_t		 initial_sdp;
    enum oa_role	 oa_role;	/**< Last role in SDP offer/answer  */
    struct sdp_state	 rem_offer_state;/**< Describes the remote offer    */
    
    void		*stream;
    pj_sockaddr		 remote_rtp;
    pj_sockaddr		 remote_rtcp;
    unsigned		 addr_len;	/**< Length of addresses.	    */
    
    pj_bool_t		 use_ice;
    pj_sockaddr		 rtp_src_addr;	/**< Actual source RTP address.	    */
    pj_sockaddr		 rtcp_src_addr;	/**< Actual source RTCP address.    */
    unsigned		 rtp_src_cnt;	/**< How many pkt from this addr.   */
    unsigned		 rtcp_src_cnt;  /**< How many pkt from this addr.   */
    
    unsigned		 tx_drop_pct;	/**< Percent of tx pkts to drop.    */
    unsigned		 rx_drop_pct;	/**< Percent of rx pkts to drop.    */
    
    void	       (*rtp_cb)(void*,
                             void*,
                             pj_ssize_t);
    void	       (*rtcp_cb)(void*,
                              void*,
                              pj_ssize_t);
};

struct pj_turn_sock
{
    pj_pool_t		*pool;
    const char		*obj_name;
    pj_turn_session	*sess;
    pj_turn_sock_cb	 cb;
    void		*user_data;
    
    pj_bool_t		 is_destroying;
    pj_grp_lock_t	*grp_lock;
    
    pj_turn_alloc_param	 alloc_param;
    pj_stun_config	 cfg;
    pj_turn_sock_cfg	 setting;
    
    pj_timer_entry	 timer;
    
    int			 af;
    pj_turn_tp_type	 conn_type;
    pj_activesock_t	*active_sock;
    pj_ioqueue_op_key_t	 send_key;
};

#endif /* ios_pj_ice_h */
