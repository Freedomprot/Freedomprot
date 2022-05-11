/**
 *Submitted for verification at BscScan.com on 2022-02-18
*/

// SPDX-License-Identifier: Unlicensed
//
// SAFUU PROTOCOL COPYRIGHT (C) 2022

pragma solidity ^0.7.4;

library SafeMathInt {
    int256 private constant MIN_INT256 = int256(1) << 255;
    int256 private constant MAX_INT256 = ~(int256(1) << 255);

    function mul(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a * b;

        require(c != MIN_INT256 || (a & MIN_INT256) != (b & MIN_INT256));
        require((b == 0) || (c / b == a));
        return c;
    }

    function div(int256 a, int256 b) internal pure returns (int256) {
        require(b != -1 || a != MIN_INT256);

        return a / b;
    }

    function sub(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a - b;
        require((b >= 0 && c <= a) || (b < 0 && c > a));
        return c;
    }

    function add(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a + b;
        require((b >= 0 && c >= a) || (b < 0 && c < a));
        return c;
    }

    function abs(int256 a) internal pure returns (int256) {
        require(a != MIN_INT256);
        return a < 0 ? -a : a;
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender)
    external
    view
    returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface IPancakeSwapPair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IPancakeSwapRouter{
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IPancakeSwapFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

contract Ownable {
    address private _owner;

    event OwnershipRenounced(address indexed previousOwner);

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipRenounced(_owner);
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

abstract contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
}


contract FreeToken is ERC20Detailed, Ownable {

    using SafeMath for uint256;
    using SafeMathInt for int256;

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);


    mapping(address => bool) _isFeeExempt;

    modifier validRecipient(address to) {
        require(to != address(0x0));
        _;
    }

    uint256 public constant DECIMALS = 8;
    uint256 public constant MAX_UINT256 = ~uint256(0);
    uint8 public constant RATE_DECIMALS = 8;


    uint256 public liquidityFee = 50; //5%  only for buy
    uint256 public treasuryFee = 50;//5% only for sell
    uint256 public consensusFundFee = 25;//2.5% only for sell
    uint256 public daoFee = 50;//5% dao fee.only for sell
    uint256 public firePitFee = 25;//2.5% only for sell
    uint256 public inviteFee = 100;//10% //only for buy
    uint256 public feeDenominator = 1000;
    uint256 public totalInviteAmount = 0;

    address DEAD = 0x000000000000000000000000000000000000dEaD;
    address ZERO = 0x0000000000000000000000000000000000000000;

    address public autoLiquidityReceiver;
    address public treasuryReceiver;
    address public firePit;
    bool public swapEnabled = true;
    IPancakeSwapRouter public router;
    address public pair;
    address public usdtAddress;
    uint256 private TOTAL_GONS;

    uint256 private constant MAX_SUPPLY = ~uint128(0);

    bool public _autoRebase;
    uint256 public _lastRebasedTime;
    uint256 public _totalSupply;
    uint256 private _gonsPerFragment;
    uint256 public pairBalance;
    mapping(address => uint256) private _gonBalances;
    mapping(address => mapping(address => uint256)) private _allowedFragments;
    mapping(address => bool) public blacklist;
    address public freeDaoAddress;
    constructor(address _swapRouter,address _freeDaoAddress,address _autoLiquidityReceiver,address _firePit,address _usdt) ERC20Detailed("FREEDOM PROTOCOL TOKEN","FREE", uint8(DECIMALS)) Ownable() {
        require(_swapRouter!=address(0),"invalid swap router address");
        require(_freeDaoAddress!=address(0),"invalid free dao address");
        require(_usdt!=address(0),"invalid usdt address");
        require(_autoLiquidityReceiver!=address(0),"invalid auto liquidity receiver");
        require(_firePit!=address(0),"invalid fire pit address");
        freeDaoAddress = _freeDaoAddress;
        usdtAddress = _usdt;
        router = IPancakeSwapRouter(_swapRouter);
        pair = IPancakeSwapFactory(router.factory()).createPair(
            usdtAddress,
            address(this)
        );
        _totalSupply = 21000000*10**DECIMALS;
        TOTAL_GONS =
        MAX_UINT256 - (MAX_UINT256 % _totalSupply);
        autoLiquidityReceiver = _autoLiquidityReceiver;
        firePit = _firePit;


        _gonBalances[msg.sender] = TOTAL_GONS;
        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);
        //_lastRebasedTime = block.timestamp;
        _autoRebase = false;
        _isFeeExempt[msg.sender] = true;
        _isFeeExempt[address(this)] = true;
        _isFeeExempt[freeDaoAddress] = true;


        emit Transfer(address(0x0), msg.sender, _totalSupply);
    }

    function rebase() internal {
        uint256 rebaseRate = 21447;
        uint256 deltaTime = block.timestamp - _lastRebasedTime;
        uint256 times = deltaTime.div(15 minutes);
        uint256 epoch = times.mul(15);


        for (uint256 i = 0; i < times; i++) {
            _totalSupply = _totalSupply
            .mul((10**RATE_DECIMALS).add(rebaseRate))
            .div(10**RATE_DECIMALS);
        }

        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);
        _lastRebasedTime = _lastRebasedTime.add(times.mul(15 minutes));

        emit LogRebase(epoch, _totalSupply);
    }

    function transfer(address to, uint256 value)
    external
    override
    validRecipient(to)
    returns (bool)
    {
        _transferFrom(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override validRecipient(to) returns (bool) {

        if (_allowedFragments[from][msg.sender] != uint256(-1)) {
            _allowedFragments[from][msg.sender] = _allowedFragments[from][
            msg.sender
            ].sub(value, "Insufficient Allowance");
        }
        _transferFrom(from, to, value);
        return true;
    }



    function _transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) internal returns (bool) {

        require(!blacklist[sender] && !blacklist[recipient], "in_blacklist");

        if (shouldRebase()) {
            rebase();
        }

        uint256 gonAmount = amount.mul(_gonsPerFragment);
        if (recipient==pair&&!_isFeeExempt[sender]&&!_isFeeExempt[recipient]){
            //only can sell 99% of balance
            require(gonAmount<=_gonBalances[sender].mul(99).div(100),"only can sell 99% of balance");
        }
        if (sender==pair){
            pairBalance = pairBalance.sub(amount);
        }else{
            _gonBalances[sender] = _gonBalances[sender].sub(gonAmount);
        }
        uint256 gonAmountReceived = shouldTakeFee(sender, recipient)
        ? takeFee(sender, recipient, gonAmount)
        : gonAmount;

        if (recipient==pair){
            pairBalance = pairBalance.add(gonAmountReceived.div(_gonsPerFragment));
        }else{
            _gonBalances[recipient] = _gonBalances[recipient].add(
                gonAmountReceived
            );
        }



        emit Transfer(
            sender,
            recipient,
            gonAmountReceived.div(_gonsPerFragment)
        );
        return true;
    }

    function takeFee(
        address sender,
        address recipient,
        uint256 gonAmount
    ) internal  returns (uint256) {
        uint256 _totalFee = 0;
        uint256 _treasuryFee = treasuryFee;
        //sell token or transfer token
        if (sender != pair) {
            _totalFee = firePitFee.add(treasuryFee).add(daoFee).add(consensusFundFee);//when sell token .
            _gonBalances[firePit] = _gonBalances[firePit].add(
                gonAmount.mul(firePitFee).div(feeDenominator)
            );
            emit Transfer(recipient, firePit, gonAmount.mul(firePitFee).div(feeDenominator).div(_gonsPerFragment));
            _gonBalances[treasuryReceiver] = _gonBalances[treasuryReceiver].add(
                gonAmount.mul(_treasuryFee.add(consensusFundFee)).div(feeDenominator)
            );
            emit Transfer(recipient, treasuryReceiver, gonAmount.mul(_treasuryFee.add(consensusFundFee)).div(feeDenominator).div(_gonsPerFragment));
            _gonBalances[freeDaoAddress] = _gonBalances[freeDaoAddress].add(
                gonAmount.mul(daoFee).div(feeDenominator)
            );
            emit Transfer(recipient, freeDaoAddress, gonAmount.mul(daoFee).div(feeDenominator).div(_gonsPerFragment));
        }
        if (sender == pair) {//when buy token
            _totalFee = inviteFee.add(liquidityFee);
            _gonBalances[autoLiquidityReceiver] = _gonBalances[autoLiquidityReceiver].add(
                gonAmount.mul(liquidityFee).div(feeDenominator)
            );
            emit Transfer(recipient, autoLiquidityReceiver, gonAmount.mul(liquidityFee).div(feeDenominator).div(_gonsPerFragment));

        }
        uint256 feeAmount = gonAmount.mul(_totalFee).div(feeDenominator);



 
        if (sender == pair){
            totalInviteAmount = totalInviteAmount.add(gonAmount.mul(inviteFee).div(feeDenominator).div(_gonsPerFragment));

            uint256 _inviteFee = gonAmount.mul(inviteFee).div(feeDenominator);
            _gonBalances[freeDaoAddress] = _gonBalances[freeDaoAddress].add(
                _inviteFee
            );
            emit Transfer(recipient, freeDaoAddress, _inviteFee.div(_gonsPerFragment));



        }


        return gonAmount.sub(feeAmount);
    }




    function shouldTakeFee(address from, address to)
    internal
    view
    returns (bool)
    {
        return
       // (pair == from || pair == to) &&
        !_isFeeExempt[from]&&!_isFeeExempt[to];
    }

    function shouldRebase() internal view returns (bool) {
        return
        _autoRebase &&
        (_totalSupply < MAX_SUPPLY) &&
        msg.sender != pair  &&
        block.timestamp >= (_lastRebasedTime + 15 minutes);
    }



    function setAutoRebase(bool _flag) external onlyOwner {
        if (_flag) {
            _autoRebase = _flag;
            _lastRebasedTime = block.timestamp;
        } else {
            _autoRebase = _flag;
        }
    }



    function setFreeDaoAddress(address _address) external onlyOwner {
        require(_address!=address(0),"invalid address");

        freeDaoAddress = _address;
        _isFeeExempt[freeDaoAddress] = true;
    }
    event SetFreeTreasuryAddress(address indexed _address);
    function setFreeTreasuryAddress(address _address) external onlyOwner {
        require(_address!=address(0),"invalid address");
        treasuryReceiver = _address;
        _isFeeExempt[treasuryReceiver]=true;
        emit SetFreeTreasuryAddress( _address);

    }

    function allowance(address owner_, address spender)
    external
    view
    override
    returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
    external
    returns (bool)
    {
        uint256 oldValue = _allowedFragments[msg.sender][spender];
        if (subtractedValue >= oldValue) {
            _allowedFragments[msg.sender][spender] = 0;
        } else {
            _allowedFragments[msg.sender][spender] = oldValue.sub(
                subtractedValue
            );
        }
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
    external
    returns (bool)
    {
        _allowedFragments[msg.sender][spender] = _allowedFragments[msg.sender][
        spender
        ].add(addedValue);
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function approve(address spender, uint256 value)
    external
    override
    returns (bool)
    {
        _allowedFragments[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function checkFeeExempt(address _addr) external view returns (bool) {
        return _isFeeExempt[_addr];
    }

    function getCirculatingSupply() public view returns (uint256) {
        return
        (TOTAL_GONS.sub(_gonBalances[DEAD]).sub(_gonBalances[ZERO])).div(
            _gonsPerFragment
        );
    }


    function manualSync() external {
        IPancakeSwapPair(pair).sync();
    }

    function setFeeReceivers(
        address _autoLiquidityReceiver,
        address _firePit
    ) external onlyOwner {
        autoLiquidityReceiver = _autoLiquidityReceiver;
        firePit = _firePit;
    }


    function setWhitelist(address _addr) external onlyOwner {
        _isFeeExempt[_addr] = true;
    }

    function setBlacklist(address _address, bool _flag) external onlyOwner {
        blacklist[_address] = _flag;
    }



    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address who) external view override returns (uint256) {
        if (who==pair){
            return pairBalance;
        }else{
            return _gonBalances[who].div(_gonsPerFragment);
        }
    }



}